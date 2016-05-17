function [ J ] = generateJacobian_A(T,q1,q2,q3)
%GENERATEJACOBIAN Summary of this function goes here
%   Detailed explanation goes here
%%syms q1 q2 q3
J = [diff(T(1,4),q1) diff(T(1,4),q2) diff(T(1,4),q3);
     diff(T(2,4),q1) diff(T(2,4),q2) diff(T(2,4),q3);
     diff(T(3,4),q1) diff(T(3,4),q2) diff(T(3,4),q3)];
end

