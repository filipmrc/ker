function [ A ] = path_planning( qA,qB,qC,dq,dqT,T )
% Function returns the coeffs of the cubic spline 

mu = 0.7;

M1 = [    0        0        0      0  1
      (mu*T)^4 (mu*T)^3 (mu*T)^2 mu*T 1
          T^4      T^3      T^2     T 1
          0        0        0       1 0
        4*T^3    3*T^2    2*T       1 0];

Q1 = [qA, qB, qC, dq, dqT]';

A = (M1^(-1))*Q1;

end

