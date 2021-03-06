function Ydash = TrPredict(X, svmmodels, beta)
    N = length(svmmodels);
    start = ceil(N/2);
    l = size(X,1);
    yOne = ones(l,1);
    yTwo = ones(l,1);
    Ydash = ones(l,1);
    for i = start:N
        predict = svmclassify(svmmodels{i},X);
        yOne = yOne.*((beta(start)*ones(l,1)).^(-predict));
        yTwo = yTwo.*((beta(start)*ones(l,1)).^(-0.5));
    end
    Ydash(yOne < yTwo) = 0;
end