function [model, beta ] = TrAdaboostTrain(tdX,tdY,tsX,tsY)
tX = [tdX ; tsX];
tY = [tdY ; tsY];
n = size(tdY,1);
m = size(tsY,1);
T = 20;
w = rand(m+n,1);
model = cell(1,T);
beta = zeros(1,T);
for t = 1:T
    p = w./(sum(abs(w)));
    [alpha] = mysvmnonseparabledual(tX, tY,p);
    predict = predictNonLinear(tX,alpha,tX,tY);
    model{t} = alpha;
    %     model{t} = svmtrain(tX,tY,'kernel_function','linear','boxconstraint',(n+m)*p);
    %     predict = svmclassify(model{t},tX);
    sW = sum(w(n+1:m+n));
    et = sum(w(n+1:m+n).*(abs(predict(n+1:m+n)-tsY))/sW)
    
    if (et >= 0.5 && t~=1)
        model = model(1:t-1);
        beta = beta(1:t-1);
        break;
    end
    bT = et/(1-et);
    beta(t) =bT;
    b = 1/(1+sqrt(2*log(n)/T));
    wUpdate = [(b*ones(n,1)).^(abs(predict(1:n)-tdY)) ; (bT*ones(n,1)).^(abs(predict(n+1:m+n)-tsY)) ];
    w = w.*wUpdate;
end
end