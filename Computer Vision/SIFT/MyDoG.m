function [dog] = MyDoG(octave)
    cellSize = size(octave,2);
    dog = cell(1,cellSize-1);
    for i = 1:cellSize-1
        dog{1,i} = octave{1,i+1}-octave{1,i};
    end
end