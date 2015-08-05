function[discriminant1,discriminant2]=lindiscriminant(X,Y,degree)
plotPoints([X(:,2),X(:,3)],Y); 
hold on;


X=X(:,2:end);
negX = X(Y ==0,:);
posX = X(Y ==1,:);

pie1=sum(Y==0)/100;
pie2=sum(Y==1)/100;
mean1 = mean(negX);
mean2 = mean(posX);

summ = 0;

for j =1:size(negX,1)
    summ = summ + (negX(j,:)' - mean1')* (negX(j,:)' - mean1')';
end
for j =1:size(posX,1)
    summ = summ + (posX(j,:)' - mean2')* (posX(j,:)' - mean2')';
end

summ=summ/(length(Y)-2);

discriminant1=(negX)*inv(summ)*mean1'-0.5*mean1*inv(summ)*mean1'+log(pie1);
discriminant2=(posX)*inv(summ)*mean2'-0.5*mean2*inv(summ)*mean2'+log(pie2);

[u,v] = meshgrid(0:0.1:10,0:0.1:10);

z = zeros(size(u));
for i = 1:101
    for j = 1:101
        xTemp = featuretransform([u(i,j),v(i,j)],degree);
        xTemp = xTemp(:,2:end);
        z(i,j)= xTemp*inv(summ)*transpose(mean1-mean2)-0.5*mean1*inv(summ)*transpose(mean1)+0.5*mean2*inv(summ)*transpose(mean2)+log(pie1)-log(pie2);
    end
end

contour(u,v,z,[0 0]);   

end






