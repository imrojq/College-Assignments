function[elimPoints] = MyEliminateKeypoints(keyPoints,dog)
elimPoints = [];
keySize = size(keyPoints,1);
cThres = 0.5;
for i=1:keySize
    point = keyPoints(i,:);
    if ( abs(dog{1,point(2)}(point(3),point(4))) > cThres)
        elimPoints = [ elimPoints ; point];
    end
end


R = cell(size(dog));


end