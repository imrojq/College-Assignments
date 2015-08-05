function [Tdash] = mylinridgeregeval(X, Weights)
X = [ ones(size(X,1),1) X ];
Tdash = X * Weights;
end