clc;
clear;
close all;

run('vlfeat-0.9.18/toolbox/vl_setup')
image = imread('bicycle.bmp');
image = rgb2gray(image);
image = single(image);
% image = image/255;
[a, b] = vl_sift((image));
imshow(uint8(image));
hold on;
k=2;
e = kMeans(double(b'),k);
plot(a(1,e(1,:)==1),a(2,e(1,:)==1),'r+')
plot(a(1,e(2,:)==1),a(2,e(2,:)==1),'b+')
figure;
imshow(uint8(image));
hold on;
[e,c,d] = kmeans(double(b'),k);
plot(a(1,e==1),a(2,e==1),'r+')
hold on;
plot(a(1,e==2),a(2,e==2),'b+')
s = sum(d)

% [ cluster , centroid]  = kMeans(b,k);