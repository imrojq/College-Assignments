clc;
clear all;
close all;
rand('seed',1);
% [X,Y] = createData(50,20);
load('Q3data.mat');

P = pca(X,2);
X = X./(repmat(std(X),60,1));
 
plot(X(1:20,1), X(1:20,2), 'r+');
hold on;
plot(X(21:40,1), X(21:40,2), 'g+');
plot(X(41:60,1), X(41:60,2), 'b+');
plot([-P(1,1) P(1,1)]+mean(X(:,1)),[-P(2,1) P(2,1)]+mean(X(:,2)));
plot([-P(1,2) P(1,2)]+mean(X(:,1)),[-P(2,2) P(2,2)]+mean(X(:,2)));

figure;
 l= kMeans(X,3);
plot(X(l==1,1),X(l==1,2),'r+')
hold on;
plot(X(l==2,1),X(l==2,2),'b+')
plot(X(l==3,1),X(l==3,2),'g+')
% plot(X(l==4,1),X(l==4,2),'k+')
% 
% 
%  a= kMeans(X,3);