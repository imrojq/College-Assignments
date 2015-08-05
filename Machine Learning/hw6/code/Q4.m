clear; 
close all;
clc

   load('hw6data.txt')
images = hw6data';
[m,n] = size(images);
% D = distanceMatrix(images);
k = 6;
D = createGeodesic(images,k)
S = computeS(D);
newData = zeros(size(S,1),2);
[eignVec,eignVal] = eigs(S,2);
eignVal = sqrt(diag(eignVal))';
for i = 1:size(eignVec,1)
    newData(i,:) = eignVal.*eignVec(i,:);
end
figure();
plot(newData(:,1),newData(:,2),'*r');

