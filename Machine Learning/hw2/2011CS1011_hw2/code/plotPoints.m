function plotPoints(X,y)
figure;
scatter(X(y==0,1),X(y==0,2),'r');
hold on
scatter(X(y==1,1),X(y==1,2),'b');
legend('negative','positive');
end