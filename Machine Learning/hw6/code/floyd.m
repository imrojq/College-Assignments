function Dx = floyd(Dx)
n = size(Dx,1);
for k =1:n
    for i=1:n
        for j =1:n
            Dx(i,j) = min(Dx(i,j) ,  Dx(i,k)+Dx(k,j));
        end
    end
end


end