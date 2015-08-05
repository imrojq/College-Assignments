clc
clear;
load('abalone.mat')

frac = 0.8;
lambda = 0.2;
[trainX,trainY,testX,testY] = createTrainTest(abalone,frac);
featuesToRemove = [2 5];
trainX(:,featuesToRemove) = [];
testX(:,featuesToRemove) = [];

[weights] =  mylinridgereg(trainX, trainY, lambda) ;
Tdash = mylinridgeregeval(testX, weights);
Ttrain = mylinridgeregeval(trainX, weights);
weights
meansquarederr(trainY,Ttrain)
meansquarederr(testY,Tdash)