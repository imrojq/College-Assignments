function [ weights ] =  mylinridgereg(X, T, lambda)
X = [ ones(size(X,1),1) X ]; %Add a column of ones to X .
weights = pinv((X'*X) + lambda*eye(size(X,2))) * X' * T ;
end