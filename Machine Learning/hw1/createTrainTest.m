function [trainX,trainY,testX,testY] = createTrainTest(abalone,frac)
%This function takes abalon as input then finds X and Y then converts
% 0,1,2 labels to 0,0,1. Breaks into training nd test accordding to frac and
% Standadises the data.
[numberOfSamples , numberOfColumns ] = size(abalone);
X = abalone(:,1:numberOfColumns-1);
Y = abalone(:,numberOfColumns);
randIndices = randperm(numberOfSamples);    % Shuffling of indexes 
X=X(randIndices,:);                         %Used to get new random training and test sample everytime
Y=Y(randIndices,:);
binary = [X(:,1)==0 X(:,1)==1 X(:,1)==2];   %Converts labels column into 3 column binary features 
X= [binary X(:,2:size(X,2)) ] ;
numberOfTrainSamples = floor(frac * numberOfSamples );
trainX = X(1:numberOfTrainSamples,:);       %Finding the training data
trainY = Y(1:numberOfTrainSamples,:);

%Standardization of the training data 
mu = mean(trainX);
sigma = std(trainX);
trainX=trainX-(ones(numberOfTrainSamples,1)*mu); %Subtracting the mean
for i=1:size(X,2)
    trainX(:,i)=trainX(:,i)./sigma(1,i);         %Division by standard deviation 
end
testX = X(numberOfTrainSamples+1:numberOfSamples,:); %Standardisation fo test data using mean and deviation of training data
testY = Y(numberOfTrainSamples+1:numberOfSamples,:);
testX=testX-(ones(size(testX,1),1)*mu);
for i=1:size(X,2)
    testX(:,i)=testX(:,i)./sigma(1,i);
end

end