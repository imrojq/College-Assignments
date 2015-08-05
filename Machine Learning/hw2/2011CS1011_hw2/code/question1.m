%%% ----------- Initialise--------------------%
clear ;
close all;
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


standardDeviation = 0.2;
mean1=2;
mean2=3;
mean3=4;

data1=normrnd(mean1,standardDeviation,[1 10]);
data2=normrnd(mean2,standardDeviation,[1 10]);
data3=normrnd(mean3,standardDeviation,[1 10]);

data1=sort(data1);
data2=sort(data2);
data3=sort(data3);

axis = zeros(size(data1));

scatter(data1,axis,'r')
hold on
scatter(data2,axis,'g')
hold on
scatter(data3,axis,'b')
hold on;
trainingMean1=mean(data1);
trainingMean2=mean(data2);
trainingMean3=mean(data3);
trainingStandardDeviation1=var(data1);
trainingStandardDeviation2=var(data2);
trainingStandardDeviation3=var(data3);
testData = [1:0.1:5];
axis=zeros(size(testData));

h1 = exp(-1*((testData-trainingMean1).^2)./trainingStandardDeviation1)./((2*pi*trainingStandardDeviation1)^0.5);
h2 = exp(-1*((testData-trainingMean2).^2)./trainingStandardDeviation2)./((2*pi*trainingStandardDeviation2)^0.5);
h3 = exp(-1*((testData-trainingMean3).^2)./trainingStandardDeviation3)./((2*pi*trainingStandardDeviation3)^0.5);


plot(testData,h1,'r',testData,h2,'g',testData,h3,'b')
hold on;
plot(testData,h1./3,'--r',testData,h2./3,'--g',testData,h3./3,'--b')
legend('data1','data2','data3','likelihood1','likelihood2','likelihood3','posterior1','posterior2','posterior3');
title('Likelihood and posterior probability for data');



figure;
sigma= (trainingStandardDeviation1+trainingStandardDeviation2+trainingStandardDeviation3)/27;
e1 = testData*(1/sigma)*trainingMean1 - (trainingMean1*(1/sigma)*trainingMean1)/2 + log(1/3);
e2 = testData*(1/sigma)*trainingMean2 - (trainingMean2*(1/sigma)*trainingMean2)/2 + log(1/3);
e3 = testData*(1/sigma)*trainingMean3 - (trainingMean3*(1/sigma)*trainingMean3)/2 + log(1/3);

axis = zeros(size(data1));

scatter(data1,axis,'r+')
hold on
scatter(data2,axis,'g+')
hold on
scatter(data3,axis,'b+')
hold on;

plot(testData,e1,'r.',testData,e2,'g.',testData,e3,'b.')
hold on;
comb = [e1;e2;e3];
[val,index] = max(comb);
scatter(testData(index==1),e1(index==1),'k')
hold on;
scatter(testData(index==2),e2(index==2),'k')
hold on;
scatter(testData(index==3),e3(index==3),'k')
legend('data1','data2','data3','discriminant1','discriminant2','discriminant3','Picked in Classification');
title('Discriminant values of test data');
