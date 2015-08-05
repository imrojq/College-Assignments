function [yTest] = predict(X,w0,w)
result = (w0 + w*X')';
yTest = zeros(size(X,1),1);
yTest(result > 0) =  1;
yTest (result <= 0 ) = -1;
end
