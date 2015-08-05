function [Ydash, accuracy] = TrAdaboostTest(X,Y,model,beta)
    Ydash = TrPredict(X,model,beta);
    N = size(X,1);
    accuracy = (sum(Ydash==Y))*(100/N);
end