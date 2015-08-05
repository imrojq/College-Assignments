load recvstalkmini.mat
rand('seed',1);

perc = 1;
%X=full(trdata);
Y=trlabel;
Y(Y==-1)=0;
[numberOfSamples , numberOfColumns ] = size(trdata);
randIndices = randperm(numberOfSamples);    % Shuffling of indexes 
trdata = trdata(randIndices,:);                         %Used to get new random training and test sample everytime
Y=Y(randIndices,:);
m=floor((numberOfSamples*perc)/100);
n=floor((numberOfSamples*perc)/100);
tdX = full(trdata(1:m,:));
tdY = Y(1:m,:);
tsX = full(trdata(m+1:m+n,:));
tsY = Y(m+1:m+n,:);
sX = full(trdata(m+n+1:m+n+100,:));
sY = Y(m+n+1:m+n+100,:);
[model, beta] = TrAdaboostTrain(tdX,tdY,tsX,tsY);
[HsY accuracy] = TrAdaboostTest(sX,sY, model,beta);