function [ broj ] = count_index( vector )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
broj = zeros(1,16);

for i = 1:numel(vector)
    switch(vector(i))
        case 1
            broj(1) = broj(1) + 1;
        case 2
            broj(2) = broj(2) + 1;
        case 3
            broj(3) = broj(3) + 1;
        case 4
            broj(4) = broj(4) + 1;
        case 5
            broj(5) = broj(5) + 1;
        case 6
            broj(6) = broj(6) + 1;
        case 7
            broj(7) = broj(7) + 1;
        case 8
            broj(8) = broj(8) + 1;
        case 9
            broj(9) = broj(9) + 1;
        case 10
            broj(10) = broj(10) + 1;
        case 11
            broj(11) = broj(11) + 1;
        case 12
            broj(12) = broj(12) + 1;
        case 13
            broj(13) = broj(13) + 1;
        case 14
            broj(14) = broj(14) + 1;
        case 15
            broj(15) = broj(15) + 1;
        case 16
            broj(16) = broj(16) + 1;
    end
end


end

