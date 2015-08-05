function Mask= MyGauss(Sigma,S)

Mask=zeros(S,S);
mid = floor(S/2)+1;

for i=1:S
    for j=1:S
        Mask(i,j) = exp(-1*((i-mid).^2 + (j-mid).^2)./(2*Sigma.^2));
    end
end
Mask=Mask./sum(sum(Mask));

end

