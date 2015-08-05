function test(theta,X,Y,degree)
figure;

X1=X(:,2);
X2=X(:,3);
scatter(X1(Y==0),X2(Y==0),'r');
hold on
scatter(X1(Y==1),X2(Y==1),'b');

u = linspace(0, 10, 100);
v = linspace(0, 10, 100);

z = zeros(length(u), length(v));
% Evaluate z = theta*x over the grid
for i = 1:length(u)
    for j = 1:length(v)
        z(i,j) = featuretransform([u(i), v(j)],degree)*theta;
    end
end
z = z'; % important to transpose z before calling contour
a=0
% Plot z = 0
% Notice you need to specify the range [0, 0]
contour(u, v, z, [0, 0], 'LineWidth', 2)

end