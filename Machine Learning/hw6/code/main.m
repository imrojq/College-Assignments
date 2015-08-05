rand('seed', 1);
clear;
clc;
% load cereal.mat
% X = [Calories Protein Fat Sodium Fiber Carbo Sugars Shelf Potass Vitamins];
[X,Y] = createData(20,20);
D = distanceMatrix(X);
S = computeS(D);
meanS = repmat(mean(S,1),60,1);
S = S-meanS;
% cov = S'*S;
[u, sigma ,v]  = svd(cov(S));
sigma = sigma.^0.5;
an = eye(2,60)*(sigma*u');
Z = an';
% P = pca(X,2);
% Z = X*P;
%  Z = [ Z  ones(60,1)];

 plot(Z(Y(:,1)==1,1),Z(Y(:,1)==1,2),'r+')
hold on;
plot(Z(Y(:,1)==2,1),Z(Y(:,1)==2,2),'g+')
plot(Z(Y(:,1)==3,1),Z(Y(:,1)==3,2),'b+')
% plot(Z(1,Y(2,:)==2),Z(2,Y(2,:)==2),'b+')
% plot(Z(1,Y(2,:)==3),Z(2,Y(2,:)==3),'g+')