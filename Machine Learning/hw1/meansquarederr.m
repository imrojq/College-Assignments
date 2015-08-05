function [meanError] = meansquarederr(T, Tdash)
    meanError = mean(((T-Tdash).*(T-Tdash))) ;
end 