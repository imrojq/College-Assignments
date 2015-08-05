function HybridImage = MyHybrid(img,img2,c,c2)
clc
n=2;
% c2=60;
% c=40;
% img = imread ('Samples\cat.bmp');
% img2 = imread('Samples\dog.bmp');
img = double (img);
img2 = double(img2);
dim = size(img);
rows = dim(1);
cols = dim(2);

imgt = zeros (rows*n, cols*n,3);
imgt (1:rows, 1:cols,: ) = img;
imgt2 = zeros (rows*n, cols*n,3);
imgt2 (1:rows, 1:cols,: ) = img2;


for i=1 : 1 : rows*2
	for j=1 : 1 : cols*2
		imgt (i,j,:) = imgt (i,j,:) * (-1)^(i+j);
        
		imgt2 (i,j,:) = imgt2 (i,j,:) * (-1)^(i+j);
	end
end

for i=1:3
    imgt(:,:,i) = fft2 (imgt(:,:,i));
    
    imgt2(:,:,i) = fft2 (imgt2(:,:,i));
end
H=zeros(rows*n, cols*n);
H2=zeros(rows*n, cols*n);



for i=1:1: rows*n
	for j=1:1:cols*n
		d = (((rows*n)/2-i)^2 + ((cols*n)/2-j)^2)^0.5;
		H(i,j)= exp(-1*d^2/(2*c^2));
	end
end

for i=1:1: rows*n
	for j=1:1:cols*n
		d = (((rows*n)/2-i)^2 + ((cols*n)/2-j)^2)^0.5;
		H2(i,j)= 1-exp(-1*d^2/(2*c2^2));
	end
end


for i=1:3
    G(:,:,i) = H.*imgt(:,:,i);
    G2(:,:,i) = H2.*imgt2(:,:,i);
    res(:,:,i)= G(:,:,i)+G2(:,:,i);
    res(:,:,i) = real(ifft2(res(:,:,i))); 
    imgt(:,:,i) = ifft2(G(:,:,i));
	
    imgt(:,:,i)=real(imgt(:,:,i));
    
    imgt2(:,:,i) = ifft2(G2(:,:,i));
	
    imgt2(:,:,i)=real(imgt2(:,:,i));
end

%res=imgt+imgt2;

for i = 1 : 1 : rows*2
	for j = 1 : 1 : cols*2 
    res(i,j,:)=res(i,j,:)*((-1)^(i+j));
    imgt (i,j,:) = imgt(i,j,:)*((-1)^(i+j));
%         
 		imgt2 (i,j,:) = imgt2(i,j,:)*((-1)^(i+j));
	end
end


im = res(1:rows, 1:cols,:);

im=uint8(im);

HybridImage =im;


end