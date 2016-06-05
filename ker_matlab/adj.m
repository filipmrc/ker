function [A] = adj(T)
%ADJ Adjoint of homogenous transformation matrix
%   Detailed explanation goes here
R = T(1:3,1:3);
P = T; P = P(1:3,4);
p = [0 -P(3) P(2); P(3) 0 -P(1); -P(2) P(1) 0];
A = [R p*R; zeros(3,3) R];

end

