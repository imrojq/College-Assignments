%%% ----------- Initialise--------------------%
clear ;
close all;
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('abalone.mat')

plotNumber=1;
figure;
minErrorVector=[];
minIndexVector=[];
lambdaValues = 0:0.1:1;
fracValues = 0.1:0.1:0.9;
for frac = fracValues
    trainErrorVector = [];
    testErrorVector = [];
    for lambda = lambdaValues
        lambda
        trainErrorSum = 0;
        testErrorSum = 0;
        for iter = 1:1:100
            iter
            [trainX,trainY,testX,testY] = createTrainTest(abalone,frac);
            [weights] =  mylinridgereg(trainX, trainY, lambda) ;
            Tdash = mylinridgeregeval(testX, weights);
            Ttrain = mylinridgeregeval(trainX, weights);
            trainErrorSum = trainErrorSum + meansquarederr(trainY,Ttrain);
            testErrorSum = testErrorSum + meansquarederr(testY,Tdash);
        end
        averageTrainError = trainErrorSum /100;
        averageTestError = testErrorSum /100;
        trainErrorVector = [trainErrorVector averageTrainError];
        testErrorVector = [testErrorVector averageTestError];
    end
    % Plots the graph of lambda vs mean square error for Each value of
    % fraction
    subplot(3,3,plotNumber);
    plot(lambdaValues,trainErrorVector,'r');
    hold on
    plot(lambdaValues,testErrorVector,'b');
    ylim([4.5 5.4]);
    xlabel('Lambda');
    ylabel('Mean Square Error');
    title(strcat('Train/Test split fraction = ',num2str(frac)));
    plotNumber = plotNumber +1 ;
    [minError,minIndex] = min(testErrorVector);
    minErrorVector = [minErrorVector minError ];
    minIndexVector = [minIndexVector minIndex ];
end

figure;
%Plots the graph between Minimum average mean squared testing error and the
%training test split fraction
plot(fracValues , minErrorVector);
xlabel('Train/Test Fraction');
ylabel('Minimum Mean Square Error');
title('Minimum average mean squared testing error vs Fraction');
figure;
%Plots the graph between value of lambda with minimum average mean squared
% testing error and the training test split fraction
plot(fracValues , lambdaValues(minIndexVector));
xlabel('Train/Test Fraction');
ylabel('Lambda with Minimum Mean Square Error');
title('Lambda with minimum average mean squared testing error vs Fraction');

% Finding the combination of lambda and fraction with minimum test error
[minMinError , minErrorFractionIndex ] = min(minErrorVector);
minErrorFraction = fracValues(minErrorFractionIndex)
minErrorLambdaIndex = minIndexVector(minErrorFractionIndex);
minErrorLambda = lambdaValues(minErrorLambdaIndex)
[trainX,trainY,testX,testY] = createTrainTest(abalone,minErrorFraction);
[weights] =  mylinridgereg(trainX, trainY, lambda) ;
Tdash = mylinridgeregeval(testX, weights);
Ttrain = mylinridgeregeval(trainX, weights);
figure;        
%plotting the predicted and actual values for test data 
scatter(testY,Tdash);
hold on
plot(0:1:25,0:1:25,'r');  %x=y line for comparison
xlabel('Actual Value');
ylabel('Predicted Value');
title('Actual Value vs Predicted Value for test data');
figure;
%plotting the predicted and actual values for test data
scatter(trainY,Ttrain);
hold on
plot(0:1:25,0:1:25,'b');  %x=y line for comparison
xlabel('Actual Value');
ylabel('Predicted Value');
title('Actual Value vs Predicted Value for training data');

