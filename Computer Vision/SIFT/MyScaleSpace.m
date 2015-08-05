function [octave] = MyScaleSpace(img)

k= sqrt(2);
sigma = 0.8;
numOctaves = 1;
numK = 5;
octave = cell(numOctaves , numK);
size = 9;
newSigma = sigma ;
for i =1:numK
     Mask = MyGauss( newSigma,size );
     octave{1,i} = MyConv(img,Mask);
     newSigma = newSigma * k; 
end
end