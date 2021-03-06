function ImageConv = MyCorr(ImageIn, Mask)
    ImageConv = zeros(size(ImageIn));
    [d e f] = size(ImageIn);
    for num = 1:f
        
        imageI = ImageIn(:,:,num);
        result = zeros(size(imageI));
        [x y] = size(Mask);
        [a b] = size(imageI);
        imageI = padarray(imageI,[floor(x/2) floor(y/2)]);
        for i=floor(x/2)+1:floor(x/2)+a
            for j=floor(y/2)+1:floor(y/2)+b
                result(i-floor(x/2),j-floor(y/2)) = sum(sum(imageI(i-floor(x/2):i+floor(x/2),j-floor(y/2):j+floor(y/2)).*Mask));
            end
        end
        result=uint8(result);
        ImageConv(:,:,num) = result;
    end
end