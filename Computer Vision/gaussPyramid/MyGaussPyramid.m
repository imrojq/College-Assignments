function MyGaussPyramd(im)
Sigma=0.8;
S = 5;
%imshow(im)
 Mask = MyGauss(Sigma,S);
Y=im;
immu_x=0;
immu_size=0.5;
for k=1:5
    
  %  figure();
    Y = MyCorr(double(Y),Mask);
    [a b m] = size(Y);
    
    Y(1:2:a,:,:) = [];
    %keyboard
    Y(:,1:2:b,:) = [];
    subplot('position',[immu_x 0 immu_size immu_size]);
    immu_x=immu_size+immu_x;
    immu_size=immu_size/2;
    imshow(uint8(Y))
    
end