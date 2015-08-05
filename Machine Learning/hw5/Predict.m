function Ydash = Predict(X, svmmodels, alpha)
    T = length(svmmodels);
    Ydash = zeros(size(X,1),1);
    for i = 1:T
        predict = svmclassify(svmmodels{i},X);
        Ydash(:) = Ydash(:) + alpha(i)*predict;
    end
    Ydash = sign(Ydash);
end