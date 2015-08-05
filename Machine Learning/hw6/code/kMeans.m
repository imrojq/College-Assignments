function  [clusterVal centroidsValue ] =kMeans(features,k)
features = normalizeData(features);
[numPoints,d] = size(features);
randInt = randi([1 k],numPoints,1);
initCluster = zeros(k,numPoints);
for i = 1:numPoints
    initCluster(randInt(i),i) =1;
end
centroidsValue = (initCluster*features)./repmat(sum(initCluster,2),1,d);
max_iter = 10;
J = findCost(features,initCluster,centroidsValue);
for i =1:max_iter
    clusterNumber = assignCluster(features,centroidsValue);
    size(clusterNumber);
    size(centroidsValue);
    J = findCost(features,clusterNumber,centroidsValue);
    centroidsValue = (clusterNumber*features)./repmat(sum(clusterNumber,2),1,d); 
    J = findCost(features,clusterNumber,centroidsValue);
end
clusterVal = sum(repmat([1:k],numPoints,1).*clusterNumber',2);
