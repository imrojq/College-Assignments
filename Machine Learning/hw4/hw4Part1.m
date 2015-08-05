%% Initialization
clear ; close all; clc


load('dataset1.mat');
rand('seed', 1);
[m,n] = size(X);
cv = cvpartition(Y,'kfold',10);
error = [];
time = []
for i = 1:cv.NumTestSets
    tic()
    trainIndex =  cv.training(i);
    testIndex = cv.test(i);
    trainX = X(trainIndex,:);
    testX = X(testIndex,:);
    trainY = Y(trainIndex,:);
    testY = Y(testIndex,:);
    [alpha] = mysvmseparabledual(trainX, trainY);
    indexList  = find(alpha>0.000001);
    index = indexList(1);
    w = (alpha.*trainY)'*trainX
    w0 = (1/trainY(index,:)) - w*trainX(index,:)'
    predictY = predict(testX,w0,w);
    error = [error mean(double(predictY ~= testY)*100)];
    time = [time toc];
   
end
plotPoints(X,Y,w0,w);
%plot(X(indexList,1),X(indexList,2),'y*');
accuarcy = 100 - error
time
avgAccuracy = 100 - mean(error)
avgTime = mean(time)