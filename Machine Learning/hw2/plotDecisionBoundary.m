function plotDecisionBoundary(w,X,Y,degree)
plotPoints([X(:,2),X(:,3)],Y);
hold on;

[u,v] = meshgrid(0:0.1:10,0:0.1:10);
z = zeros(size(u));

for i = 1:101
    for j = 1:101
        z(i,j) = sigmoid(featuretransform([u(i,j),v(i,j)],degree)*w);
    end
end

contour(u, v, z,[0.5,0.5])
end

