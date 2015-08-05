function [] = testScript()
img = imread('bicycle.bmp');
MySIFT(img);
figure;
img = imread('rotateBicycle.bmp');
MySIFT(img);


end