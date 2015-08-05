function [X,Y] = createData(numFeatures,N)
classAvg = randi([1 10],3,numFeatures);
% classAvg = [ones(1,numFeatures) ; ones(1,numFeatures)*5 ;ones(1,numFeatures)*10];

% standard deviation for the three classes
% "increase this quantity to increase the overlap between the classes"
% change this quantity to 0.75 when solving 1(f).
sd=0.5;

% number of data points per class

% generate data points for the three classes
x1=randn(N,numFeatures)*sd+ones(N,1)*classAvg(1,:) ;
x2=randn(N,numFeatures)*sd+ones(N,1)*classAvg(2,:) ;
x3=randn(N,numFeatures)*sd+ones(N,1)*classAvg(3,:) ;

X= [x1;x2;x3];
Y = [ones(N,1) ; 2*ones(N,1) ; 3*ones(N,1)];

end