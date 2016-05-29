function [dXdqa, dFPLdqa] = dXdq( T_fg , T_bg, FPG, q_leg)
%DXDQ Translation Jacobian calculation of point in local KER COB frame  
%   Translation Jacobian calculation of point in local KER COB frame with
%   respect to joint positions

global J1A J2A J3A J4A

T_fb = T_fg/T_bg;
X = T_fb(1:3,4); %pozicija točke u COB

FPB = [T_bg\[FPG(1:3);1] T_bg\[FPG(4:6);1] T_bg\[FPG(7:9);1] T_bg\[FPG(10:12);1]]; %noge u COB
FPB = FPB(1:3,:);
FPL = [T_fb\[FPB(1:3,1);1] T_fb\[FPB(1:3,2);1] T_fb\[FPB(1:3,3);1] T_fb\[FPB(1:3,4);1]];
FPL = FPL(1:3,:);

%pretpostavka da je poz jakobijan centra mase isti kao za centar tijela
J1_A =  J1A(q_leg(1), q_leg(2), q_leg(3));% naprijed lijevo
J2_A =  J2A(q_leg(4), q_leg(5), q_leg(6));% naprijed desno
J3_A =  J3A(q_leg(7), q_leg(8), q_leg(9));% straga desno
J4_A =  J4A(q_leg(10), q_leg(11), q_leg(12));% straga lijevo

dFPLdqa = {J1_A, J2_A, J3_A, J4_A};

dFPLdq  = [J1_A zeros(3,9); zeros(3,3) J2_A zeros(3,6); zeros(3,6) J3_A zeros(3,3); zeros(3,9) J4_A];
dLdFPL = zeros(4,12);
dLdFPL(1,1:3) = FPL(:,1)/norm(FPL(:,1)); dLdFPL(2,4:6) = FPL(:,2)/norm(FPL(:,2)); dLdFPL(3,7:9) = FPL(:,3)/norm(FPL(:,3)); dLdFPL(4,10:12) = FPL(:,4)/norm(FPL(:,4));
dLdX = [(X - FPB(:,1))'/norm(X - FPB(:,1)); (X - FPB(:,2))'/norm(X - FPB(:,2)); ...
    (X - FPB(:,3))'/norm(X - FPB(:,3)); (X - FPB(:,4))'/norm(X - FPB(:,4))];

dXdqa = pinv(dLdX)*dLdFPL*dFPLdq; 

end

