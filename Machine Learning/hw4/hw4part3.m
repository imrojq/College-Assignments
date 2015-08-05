% Initialization
clear ; close all; clc


load('dataset3.mat');
rand('seed', 1);
cv = cvpartition(Y,'kfold',10);
error = [];
time = [];
for i = 1:cv.NumTestSets
    tic()
    trainIndex =  cv.training(i);
    testIndex = cv.test(i);
    trainX = X(trainIndex,:);
    testX = X(testIndex,:);
    trainY = Y(trainIndex,:);
    testY = Y(testIndex,:);
    svmModel = svmtrain(trainX, trainY,'method','SMO','Kernel_Function',@kernelFunction,'BoxConstraint',1,'showplot',true);
    predictY = svmclassify(svmModel, testX);
    error = [error mean(double(predictY ~= testY)*100)];
    time = [time toc()];
   
end
Accuracy = 100 - mean(error)
meanTime = mean(time)
