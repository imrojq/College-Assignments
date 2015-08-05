% Initialization
clear ; close all; clc

load('dataset2.mat');
rand('seed', 1);
[m,n] = size(X);
figure;
plot(X(Y==1,1),X(Y==1,2),'r*');
hold on;
plot(X(Y==-1,1),X(Y==-1,2),'b*');
cv = cvpartition(m,'kfold',10);
error = [];
C = 1;
epsilon = C*1e-6;
time = [];
for i = 1:cv.NumTestSets
    tic()
    trainIndex =  cv.training(i);
    testIndex = cv.test(i);
    trainX = X(trainIndex,:);
    testX = X(testIndex,:);
    trainY = Y(trainIndex,:);
    testY = Y(testIndex,:);
    [alpha] = mysvmnonseparabledual(trainX, trainY,@kernelFunction,C);
    indexList  =  alpha>epsilon ;
%    plot(trainX(indexList,1),trainX(indexList,2),'y*');
    time = [time toc];
    predictY = predictNonLinear(testX,trainY,alpha,indexList,trainX,@kernelFunction);
%    plotPointsNL(trainX,alpha,trainY,indexList,@kernelFunction);
    error = [error mean(double(predictY ~= testY)*100)];
    
end
accuarcy = 100 - error
time
avgAccuracy = 100 - mean(error)
avgTime = mean(time)

