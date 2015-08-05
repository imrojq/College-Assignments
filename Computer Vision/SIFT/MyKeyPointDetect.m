function[keyPoints] = MyKeyPointDetect(dog)
dogSize = size(dog,2);
keyPoints = [];
for i = 1:dogSize
    dog{1,i} = padarray(dog{1,i},[1 1]);
end
[size1,size2] = size(dog{1,i});
for i = 2:dogSize-1
    for j = 2: size1-1
        for k= 2:size2-1
            isMin = 1;
            isMax = 1;
            val = dog{1,i}(j,k);
            for x = -1:1
                for y=-1:1
                    for z =-1:1
                        if (~(x == 0 && y==0 && z==0))
                            if (dog{1,i+x}(j+y,z+k) <= val)
                                isMin = 0;
                            end
                            if (dog{1,i+x}(j+y,z+k) >= val)
                                isMax = 0;
                            end
                        end
                    end
                end
            end
            if ( isMin ==1 || isMax == 1)
                keyPoints = [keyPoints;[1 i j-1 k-1]];
            end
        end
    end
end
end
            
                            
                                
    
    
 