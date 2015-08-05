function [Ydash, accuracy] = TrAdaboostTest(X,Y,model,beta,tX,tY)
    Ydash = TrPredict(X,model,beta,tX,tY);
    N = size(X,1);
    accuracy = (sum(Ydash==Y))*(100/N);
end