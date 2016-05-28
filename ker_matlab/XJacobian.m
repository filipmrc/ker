function [ J ] = XJacobian(T_fg, T_bg, dXBdq, dXdq, dRBdq )
%BPOINTJACOBIAN Summary of this function goes here
%   Detailed explanation goes here

RB = T_bg(1:3,1:3);
T_fb = T_fg/T_bg;
X = T_fb(1:3,4);
J = zeros(3 ,12);

k = 1;
for i = 1:12
    J(:,i) = dXBdq(:,i) + RB*dXdq(:,i) +  dRBdq(:,k:k+2)*X;
    k = k+3;
end

%J(:,1) = dXBdq(:,1) + RB*dXdq(:,1) +  dRBdq(:,1:3)*X;


end

