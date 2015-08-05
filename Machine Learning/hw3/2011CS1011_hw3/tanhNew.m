function g = tanhNew(z)
g = (exp(z) - exp(-z)) ./ (exp(z) + exp(-z));
end
