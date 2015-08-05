function P = pca(X,K)
[n,d] = size(X);
meanX = repmat(mean(X,1),n,1);
X = X-meanX;
cov = X'*X;
[U,s,V] = svd(cov/n);
P = U(:,1:K);
P = X*P;
end
