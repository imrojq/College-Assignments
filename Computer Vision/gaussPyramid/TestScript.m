 img = imread ('image3.bmp');
 img2 = imread('image4.bmp');
 imshow(MyHybrid(img,img2,25,60));
  figure;
  
 img = imread ('image5.bmp');
 img2 = imread('image6.bmp');
 imshow(MyHybrid(img,img2,25,60));
 figure;
 
 img = imread('Samples/bicycle.bmp');
 MyGaussPyramid(img);