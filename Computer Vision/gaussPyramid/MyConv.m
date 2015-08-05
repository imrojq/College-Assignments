function ImageConv = MyConv(ImageIn, Mask)
    Mask = rot90(Mask,2);
    ImageConv = zeros(size(ImageIn));
    for num = 1:3
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
        ImageConv(:,:,num) = result;
    end
end