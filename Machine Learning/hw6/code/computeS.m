function S = computeS(D)
[m,n] = size(D);
meanY = repmat(mean(D,1),m,1);
meanX = repmat(mean(D,2),1,n);
meanXY = repmat(mean(mean(D)),m,n);
S = (D - meanX - meanY  + meanXY).*(-0.5); 


end