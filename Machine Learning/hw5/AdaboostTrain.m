function [model, alpha, Accuracy] = AdaboostTrain(X,Y)
    N = size(X,1);
    T = 500;
    D = zeros(N,1);
    D(:) = 1/double(N);
    model = cell(1,T);
    alpha = zeros(1,T);
    Accuracy = zeros(1,T);
    for t = 1:T
        model{t} = svmtrain(X,Y,'kernel_function','linear','boxconstraint',N*D);
        predict = svmclassify(model{t},X);
        et = sum(D.*(abs(predict-Y)/2));
        if (et >= 0.5 && t~=1)
            model = model(1:t-1);
            alpha = alpha(1:t-1);
            Accuracy=Accuracy(1:t-1);
            break;
        end
        alpha(t) = (1/2)*log((1-et)/et);
        YH = Y.*predict;
        Z = sum(D.*exp(-alpha(t)*YH));
        D = (D.*exp(-alpha(t)*YH))/Z;
        [~,acc] = AdaboostTest(X,Y,model(1:t),alpha(1:t));
        Accuracy(t) = acc;
    end
end