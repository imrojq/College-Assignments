function [K] = kernelFunction(X1,X2)
%Quadratic Kernel
K = (1 + X1*X2').^2;

%Linear Kernel
%  K = X1*X2';
end