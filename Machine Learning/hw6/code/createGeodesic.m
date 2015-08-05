function Dg = createGeodesic(X,k)
n = size(X,1);
Dx = distanceMatrix(X);
% Dx = squareform(pdist(X,'cityblock'));
Dg = ones(n,n)*inf;
[topkVal,topkInd] = sort(Dx,2);
topkVal = topkVal(:,1:k+1);
topkInd = topkInd(:,1:k+1);
for i =1:n
    Dg(topkInd(i,:),i) = topkVal(i,:);
    Dg(i,topkInd(i,:)) = topkVal(i,:);
end

Dg = floyd(Dg);
Dg = Dg.^2;

end