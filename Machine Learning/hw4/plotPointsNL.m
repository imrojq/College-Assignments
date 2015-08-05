function [] = plotPointsNL(X,alpha,Y,index,K)
x1plot = linspace(min(X(:,1)), max(X(:,1)), 100)';
x2plot = linspace(min(X(:,2)), max(X(:,2)), 100)';
[X1, X2] = meshgrid(x1plot, x2plot);
vals = zeros(size(X1));
newAlphaY = (alpha.*Y);
newAlphaY = newAlphaY(index,:);
Xnew = X(index,:);
Ynew = Y(index,:);
b = mean(double(Ynew - (newAlphaY'*K(Xnew,Xnew))'));
for i = 1:size(X1, 2)
   this_X = [X1(:, i), X2(:, i)];
   vals(:, i) = (b+newAlphaY'*K(Xnew,this_X))';
end

% Plot the SVM boundary
hold on
contour(X1, X2, vals, [0 0], 'Color', 'b');
contour(X1, X2, vals-1, [0 0], 'Color', 'g');
contour(X1, X2, vals+1, [0 0], 'Color', 'y');

end