load dataset1.mat
rand('seed',1);
nFold = 10;
cv = cvpartition(Y,'KFold',nFold);
Accuracy = cell(1,nFold);
trainAcc = zeros(1,nFold);
testAcc = zeros(1,nFold);
% Precision and Recall
Precision = zeros(2,nFold);
Recall = zeros(2,nFold);
% Confusion Matrix for all folds
CMat = cell(1,nFold);
for i = 1:nFold
    trainX = X(cv.training(i),:);
    trainY = Y(cv.training(i),:);
    testX = X(cv.test(i),:);
    testY = Y(cv.test(i),:);
    [model, alpha, acc] = AdaboostTrain(trainX,trainY);
    Accuracy{i} = acc;
    [Htr,acctr] = AdaboostTest(trainX,trainY, model, alpha);
    [Hts,accts] = AdaboostTest(testX,testY, model, alpha);
    fprintf('Test Accuracy for fold %d: %d\n',i,accts);
    trainAcc(i)= acctr;
    testAcc(i) = accts;
    CMat{i} = confusionmat(-testY,-Hts); 
    % True Positive
    tPos = CMat{i}(1,1);
    fPos = CMat{i}(2,1);
    tNeg = CMat{i}(2,2);
    fNeg = CMat{i}(1,2);
    if tPos~=0
        Precision(1,i) = tPos/(tPos + fPos);
        Recall(1,i) = tPos/(tPos + fNeg);
    end
    if tNeg~=0
        Precision(2,i) = tNeg/(tNeg+fNeg);
        Recall(2,i) = tNeg/(tNeg+fPos);
    end
end
fprintf('\nAverage Train Accuracy: %f\n',mean(trainAcc));
fprintf('\nAverage Test accuracy: %f\n',mean(testAcc));
avgCMat = zeros(2);
for i = 1:nFold
    avgCMat = avgCMat + CMat{i};
end
fprintf('\nAverage Confusion Matrix:\n');
avgCMat = avgCMat/nFold

fprintf('Average Precision for class 1 :  %f\nAverage Recall for class 1:  %f\n',mean(Precision(1,:)),mean(Recall(1,:)));
fprintf('Average Precision for class -1 :  %f\nAverage Recall for class -1:  %f\n',mean(Precision(2,:)),mean(Recall(2,:)));
acclen = zeros(1,nFold);
for i = 1:nFold
    acclen(i) = length(Accuracy{i});
end
maxlen = max(acclen);
accTr = zeros(1,maxlen);
for i=1:nFold
    for j=1:acclen(i)
        accTr(j) = accTr(j) + Accuracy{i}(j);
    end
end
for i=1:maxlen
    accTr(i) = accTr(i)/sum(acclen>=i);
end
figure;
plot(1:maxlen,accTr);
xlabel('Iterations');
ylabel('Average Training Accuracy');

