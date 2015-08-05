function [objval ,gradval] = objgradcompute(w, X, y,lambda)
m = length(y); 

temp=0;
for i=1:m
	a=X(i,:);
	temp=temp+(-y(i,1)*log(sigmoid(a*w)))-(1-y(i,1))*log(1-sigmoid(a*w));
end

temp=temp/m;
objval=temp;
gradval=(X'*(sigmoid(X*w)-y))./m;

for j=2:size(w)
	objval=objval+(lambda/(2*m))*(w(j,1))^2;
	gradval(j)=gradval(j)+(lambda/m)*w(j,1);
end

end
