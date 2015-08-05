function [alpha] = mysvmseparabledual(X, Y)
H = (X*X').*(Y*Y');
[size1,size2] = size(X);
F = -1.*ones(size1,1);
A =[];
b = [];
Aeq = [Y'; zeros(size1-1,size1)];
Beq = zeros(size1,1);
lb= zeros(size1,1);
x0 = double(zeros(size1,1));
ub = [];
opts = optimoptions('quadprog','Algorithm','active-set','Display','off');
alpha = quadprog(H+eye(size1)*0.001,F, A,b,Aeq,Beq,lb,ub,x0,opts);
tol = 0.000001;
alpha(alpha<tol) = 0;
end