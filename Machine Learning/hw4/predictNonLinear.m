function [yTest] = predictNonLinear(Xtest,Y,alpha,index,Xtrain,K)
newAlphaY = (alpha.*Y);
newAlphaY = newAlphaY(index,:);
Xnew = Xtrain(index,:);
Ynew = Y(index,:);
b = mean(double(Ynew - (newAlphaY'*K(Xnew,Xnew))'));
yTest = zeros(size(Xtest,1),1);
result = (b+newAlphaY'*K(Xnew,Xtest))';
yTest(result > 0) =  1;
yTest (result <= 0 ) = -1;
end
