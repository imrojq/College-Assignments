%%% ----------- Initialise--------------------%
clear ;
close all;
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('credit.mat')
plotPoints(data,label);
title('All the data points');

degree = 4 ;
lambda = 0 ;


X =  featuretransform(data,degree);
initial_w = zeros(size(X,2),1);
options = optimset('GradObj', 'on', 'MaxIter', 100);
[w , objval,exit_flag] = fminunc(@(w)(objgradcompute(w, X, label,lambda)), initial_w, options);
plotDecisionBoundary(w, X, label,degree);
title('Data doints with decision boundary for lambda ');


lindiscriminant(X,label,degree);
title('Data doints with decision boundary using discriminant function');



