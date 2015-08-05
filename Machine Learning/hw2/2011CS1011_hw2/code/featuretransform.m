function output =  featuretransform(X,degree)

output = ones(size(X,1),1);

X1 = X(:,1);
X2 = X(:,2);

for i = 1:1:degree
	for j = 0:1:i
		temp = (X1.^(i-j)).*(X2.^j);
		output = [output temp];
	end
end


end