function [alpha] =  mysvmnonseparabledual(X, Y, C)   
H = (X*X').*(Y*Y');
[size1,size2] = size(X);
F = -1.*ones(size1,1);
A =[];
b = [];
Aeq = double([Y'; zeros(size1-1,size1)]);
Beq = double(zeros(size1,1));
lb= double(zeros(size1,1));
x0 = double(zeros(size1,1));
opts = optimoptions('quadprog','Algorithm','active-set','Display','off','MaxIter',300);
[alpha ,fval,exitflag,output]= quadprog(H+eye(size1)*0.01,F, A,b,Aeq,Beq,lb,C,[],opts);
end