syms q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12
%% Generate foot to leg FK
syms a1f a2f a3f d1f d4f
as_foot_leg = [a1f a2f 0 0];
ds_foot_leg = [0 0 0 d4f];
alphas_foot_leg = [0 0 pi/2 0];
thetas_foot_leg1 = [q3 q2 q1+pi/2 0];
thetas_foot_leg2 = [q6 q5 q4+pi/2 0];
thetas_foot_leg3 = [q9 q8 q7+pi/2 0];
thetas_foot_leg4 = [q12 q11 q10+pi/2 0];

T_foot_leg1 = FK(as_foot_leg, ds_foot_leg, thetas_foot_leg1, alphas_foot_leg);
T_foot_leg2 = FK(as_foot_leg, ds_foot_leg, thetas_foot_leg2, alphas_foot_leg);
T_foot_leg3 = FK(as_foot_leg, ds_foot_leg, thetas_foot_leg3, alphas_foot_leg);
T_foot_leg4 = FK(as_foot_leg, ds_foot_leg, thetas_foot_leg4, alphas_foot_leg);

%% Generate leg to foot FK
a1 = 0.0272; a2 = 0.056; d4 = 0.05056;
as_leg_foot = [a1 a2 0 0];
ds_leg_foot = [0 0 0 d4];
alphas_leg_foot = [-pi/2 0 pi/2 0];
thetas_leg_foot1 = [q1 q2 pi/2+q3 0];
thetas_leg_foot2 = [q4 q5 pi/2+q6 0];
thetas_leg_foot3 = [q7 q8 pi/2+q9 0];
thetas_leg_foot4 = [q10 q11 pi/2+q12 0];

T_leg_foot1 = FK(as_leg_foot, ds_leg_foot, thetas_leg_foot1, alphas_leg_foot);
T_leg_foot2 = FK(as_leg_foot, ds_leg_foot, thetas_leg_foot2, alphas_leg_foot);
T_leg_foot3 = FK(as_leg_foot, ds_leg_foot, thetas_leg_foot3, alphas_leg_foot);
T_leg_foot4 = FK(as_leg_foot, ds_leg_foot, thetas_leg_foot4, alphas_leg_foot);

global leg_fk
leg_fk = matlabFunction(T_leg_foot1);
%% Generate body to leg FK
% konačni izrazi za stopala u lokalnom koordinatnom sustavu (tijela)
al = 0.073; aw = 0.036; ah = -0.0115;

T_body_leg1 = [1 0 0 al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1];
T_body_leg2 = [1 0 0 al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1];
T_body_leg3 = [1 0 0 -al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1];
T_body_leg4 = [1 0 0 -al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1];

rot = [0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];

T_body_foot1 = T_body_leg1*rot*T_leg_foot1; % naprijed lijevo
T_body_foot2 = T_body_leg2*rot*T_leg_foot2; % naprijed desno
T_body_foot3 = T_body_leg3*rot*T_leg_foot3; % straga desno
T_body_foot4 = T_body_leg4*rot*T_leg_foot4; % straga lijevo

body_foot1 = matlabFunction(T_body_foot1);
body_foot2 = matlabFunction(T_body_foot2);
body_foot3 = matlabFunction(T_body_foot3);
body_foot4 = matlabFunction(T_body_foot4);

J1_A = generateJacobian_A(T_body_foot1,q1,q2,q3); % naprijed lijevo
J2_A = generateJacobian_A(T_body_foot2,q4,q5,q6); % naprijed desno
J3_A = generateJacobian_A(T_body_foot3,q7,q8,q9); % straga desno
J4_A = generateJacobian_A(T_body_foot4,q10,q11,q12); % straga lijevo

global J1A J2A J3A J4A;

J1A = matlabFunction(J1_A);
J2A = matlabFunction(J2_A);
J3A = matlabFunction(J3_A);
J4A = matlabFunction(J4_A);

