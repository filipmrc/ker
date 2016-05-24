joints = joint_sub.LatestMessage;
q = joints.Position(1:12);
joints.Name

q_leg1 = [q(5) , q(3), q(9)];
q_leg2 = [q(6) , q(4), q(10)];
q_leg3 = [q(7) , q(2), q(12)];
q_leg4 = [q(8), q(1), q(11)];

% T_l1 = leg_fk(q_leg1(1), q_leg1(2), q_leg1(3));
% T_l2 = leg_fk(q_leg2(1), q_leg2(2), q_leg2(3));
% T_l3 = leg_fk(q_leg3(1), q_leg3(2), q_leg3(3));
% T_l4 = leg_fk(q_leg4(1), q_leg4(2), q_leg4(3));

% foot positions in body coordinate frame
T_bf1 = body_foot1(q_leg1(1), q_leg1(2), q_leg1(3));
T_bf2 = body_foot2(q_leg2(1), q_leg2(2), q_leg2(3));
T_bf3 = body_foot3(q_leg3(1), q_leg3(2), q_leg3(3));
T_bf4 = body_foot4(q_leg4(1), q_leg4(2), q_leg4(3));

% body frame in global coordinate frame
global_t = getTransform(tftree,'map','odom');
gl_tr = [global_t.Transform.Translation.X, ...
    global_t.Transform.Translation.Y, ...
    global_t.Transform.Translation.Z]';
gl_q = [global_t.Transform.Rotation.W, ...
    global_t.Transform.Rotation.X, ...
    global_t.Transform.Rotation.Y, ...
    global_t.Transform.Rotation.Z];

T_gb = quat2tform(gl_q);
T_gb(1:3,4) = gl_tr;

T_gf1 = T_gb*T_bf1; % naprijed lijevo
T_gf2 = T_gb*T_bf2;% naprijed desno
T_gf3 = T_gb*T_bf3; % straga desno
T_gf4 = T_gb*T_bf4; % straga lijevo

XB  = T_gb(1:3,4); %pozicija lokalnog koord sustava u globalnom
XB4 = [XB XB XB XB]; %pozicija lokalnog x4 radi algoritma
RB  = T_gb(1:3,1:3); %orijentacija lokalnog koordinatnog sustava u globalnom

FPL = [T_bf1(1:3,4) T_bf2(1:3,4) T_bf3(1:3,4) T_bf4(1:3,4)]; % pozicije šapa u lokalnom 
FPG = [T_gf1(1:3,4) T_gf2(1:3,4) T_gf3(1:3,4) T_gf4(1:3,4)]; %pozicije šapa u globalnom

J1_A =  J1A(q_leg1(1), q_leg1(2), q_leg1(3));% naprijed lijevo
J2_A =  J1A(q_leg2(1), q_leg2(2), q_leg2(3));% naprijed desno
J3_A =  J1A(q_leg3(1), q_leg3(2), q_leg3(3));% straga desno
J4_A =  J1A(q_leg4(1), q_leg4(2), q_leg4(3));% straga lijevo

dFPLdq  = [J1_A zeros(3,9); zeros(3,3) J2_A zeros(3,6); zeros(3,6) J3_A zeros(3,3); zeros(3,9) J4_A];
dLdFPL = FPL/(sqrt(sum(sum(FPL.^2))));
dLdXB4 = (XB4 - FPG)/(sqrt(sum(sum((XB4 - FPG).^2))));

JBG_A = pinv(dLdXB4)*dLdFPL*dFPLdq; 
dXB4dq = JBG_A;

JBG_B = -(dXB4dq + RB*dFPLdq)*(FPL'*FPL)\FPL';
    