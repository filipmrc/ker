function [ dRBdq ] = dRBdq( dXdq, dFPLdq, RB, FPL )
%DRBDQ Rotation Jacobian calculation of COB
%   Detailed explanation goes here
dRBdq = zeros(3,36);

% dRBdq(:,1:3) = -(dXdq(:,1) + RB*dFPLdq(1:3,1))*pinv(FPL(1:3));
% dRBdq(:,4:6) = -(dXdq(:,2) + RB*dFPLdq(1:3,2))*pinv(FPL(1:3));
% dRBdq(:,7:9) = -(dXdq(:,3) + RB*dFPLdq(1:3,3))*pinv(FPL(1:3));
% 
% dRBdq(:,10:12) = -(dXdq(:,4) + RB*dFPLdq(4:6,4))*pinv(FPL(4:6));
% dRBdq(:,13:15) = -(dXdq(:,5) + RB*dFPLdq(4:6,5))*pinv(FPL(4:6));
% dRBdq(:,16:18) = -(dXdq(:,6) + RB*dFPLdq(4:6,6))*pinv(FPL(4:6));
% 
% dRBdq(:,19:21) = -(dXdq(:,7) + RB*dFPLdq(7:9,7))*pinv(FPL(7:9));
% dRBdq(:,22:24) = -(dXdq(:,8) + RB*dFPLdq(7:9,8))*pinv(FPL(7:9));
% dRBdq(:,25:27) = -(dXdq(:,9) + RB*dFPLdq(7:9,9))*pinv(FPL(7:9));
% 
% dRBdq(:,28:30) = -(dXdq(:,10) + RB*dFPLdq(10:12,10))*pinv(FPL(10:12));
% dRBdq(:,31:33) = -(dXdq(:,11) + RB*dFPLdq(10:12,11))*pinv(FPL(10:12));
% dRBdq(:,34:36) = -(dXdq(:,12) + RB*dFPLdq(10:12,12))*pinv(FPL(10:12));

dRBdq(:,1:3) = -([dXdq(:,1) dXdq(:,1) dXdq(:,1) dXdq(:,1)] ...
    + RB*[dFPLdq(1:3,1) zeros(3,1) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,4:6) = -([dXdq(:,2) dXdq(:,2) dXdq(:,2) dXdq(:,2)] ...
    + RB*[dFPLdq(1:3,2) zeros(3,1) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,7:9) = -([dXdq(:,3) dXdq(:,3) dXdq(:,3) dXdq(:,3)] ...
    + RB*[dFPLdq(1:3,3) zeros(3,1) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);

dRBdq(:,10:12) = -([dXdq(:,4) dXdq(:,4) dXdq(:,4) dXdq(:,4)] ...
    + RB*[ zeros(3,1) dFPLdq(4:6,4) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,13:15) = -([dXdq(:,5) dXdq(:,5) dXdq(:,5) dXdq(:,5)] ...
    + RB*[ zeros(3,1) dFPLdq(4:6,5) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,16:18) = -([dXdq(:,6) dXdq(:,6) dXdq(:,6) dXdq(:,6)] ...
    + RB*[ zeros(3,1) dFPLdq(4:6,6) zeros(3,1) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);

dRBdq(:,19:21) = -([dXdq(:,7) dXdq(:,7) dXdq(:,7) dXdq(:,7)] ...
    + RB*[ zeros(3,1) zeros(3,1) dFPLdq(7:9,7) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,22:24) = -([dXdq(:,8) dXdq(:,8) dXdq(:,8) dXdq(:,8)] ...
    + RB*[ zeros(3,1) zeros(3,1) dFPLdq(7:9,8) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,25:27) = -([dXdq(:,9) dXdq(:,9) dXdq(:,9) dXdq(:,9)] ...
    + RB*[ zeros(3,1) zeros(3,1) dFPLdq(7:9,9) zeros(3,1)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);

dRBdq(:,28:30) = -([dXdq(:,10) dXdq(:,10) dXdq(:,10) dXdq(:,10)] ...
    + RB*[ zeros(3,1) zeros(3,1) zeros(3,1) dFPLdq(10:12,10)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,31:33) = -([dXdq(:,11) dXdq(:,11) dXdq(:,11) dXdq(:,11)] ...
    + RB*[ zeros(3,1) zeros(3,1) zeros(3,1) dFPLdq(10:12,11)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
dRBdq(:,34:36) = -([dXdq(:,12) dXdq(:,12) dXdq(:,12) dXdq(:,12)] ...
    + RB*[ zeros(3,1) zeros(3,1) zeros(3,1) dFPLdq(10:12,12)])*pinv([FPL(1:3) FPL(4:6) FPL(7:9) FPL(10:12)]);
end

