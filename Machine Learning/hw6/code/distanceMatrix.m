function D = distanceMatrix(X)
n = size(X,1);
D = zeros(n,n);
for i=1:n
    for j=1:i
%         distance  = dot(X(i,:),X(j,:));
        distance  = sqrt(sum((X(i,:) - X(j,:)).^2));
        D(i,j)=distance;
        D(j,i) = distance;
    end
end

end
