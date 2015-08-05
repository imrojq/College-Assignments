function [yTest] = predictNonLinear(Xtest,alpha,Xtrain,Ytrain)
index = alpha > 0.000001;
newAlphaY = (alpha.*Ytrain);
newAlphaY = newAlphaY(index,:);
Xnew = Xtrain(index,:);
Ynew = Ytrain(index,:);
b = mean(double(Ynew - (newAlphaY'*(Xnew*Xnew'))'));
yTest = zeros(size(Xtest,1),1);
result = (b+newAlphaY'*(Xnew*Xtest'))';
yTest(result > 0) =  1;
yTest (result <= 0 ) = -1;
end
