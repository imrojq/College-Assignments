function [Ydash, accuracy] = AdaboostTest(X,Y,model,alpha)
    Ydash = Predict(X,model,alpha);
    N = size(X,1);
    accuracy = (sum(Ydash==Y))*(100/N);
end