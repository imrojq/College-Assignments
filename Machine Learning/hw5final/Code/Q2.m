load recvstalkmini.mat
rand('seed',1);

perc = 1;
Y=trlabel;
Y(Y==-1)=0;
[numberOfSamples , numberOfColumns ] = size(trdata);
accList =[];
for i=1:10
    randIndices = randperm(numberOfSamples);    % Shuffling of indexes
    trdata = trdata(randIndices,:);             %Used to get new random training and test sample everytime
    Y=Y(randIndices,:);
    m=floor((numberOfSamples*perc)/100);
    n=floor((numberOfSamples*perc)/100);
    tdX = full(trdata(1:m,:));
    tdY = Y(1:m,:);
    tsX = full(trdata(m+1:m+n,:));
    tsY = Y(m+1:m+n,:);
    [model, beta] = TrAdaboostTrain(tdX,tdY,tsX,tsY);
    sX = full(trdata(m+n+1:end,:));
    sY = Y(m+n+1:end,:);
    [HsY , accuracy] = TrAdaboostTest(sX,sY, model,beta);
    accList = [accList accuracy];
    clear sX;
end
accList
meanAccuracy = mean(accList)
stdAccracy = std(accList)