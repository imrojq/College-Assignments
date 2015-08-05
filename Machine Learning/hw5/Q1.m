load dataset1.mat
rand('seed',3.2);
cv = cvpartition(Y,'KFold',10);
Accuracy = cell(1,cv.NumTestSets);
CMat = cell(1,cv.NumTestSets);
for i = 1:cv.NumTestSets
    trainX = X(cv.training(i),:);
    trainY = Y(cv.training(i),:);
    testX = X(cv.test(i),:);
    testY = Y(cv.test(i),:);
    [model, alpha, acc] = AdaboostTrain(trainX,trainY);
    Accuracy{i} = acc;
    [Htr,acctr] = AdaboostTest(trainX,trainY, model, alpha);
    [Hts,accts] = AdaboostTest(testX,testY, model, alpha);
    CMat{i} = confusionmat(testY,Hts);
end
Avgacc = mean(Accuracy);
% for i = 1:cv.NumTestSets
%     clc
% end