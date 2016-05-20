%% Generate leg to foot FK
syms  a1 a2 a3  d1 d4 q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12
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

%% Generate body to leg FK
% konačni izrazi za stopala u lokalnom koordinatnom sustavu (tijela)
syms al aw ah
as_body_leg1 = [al aw ah];
as_body_leg2 = [al -aw ah];
as_body_leg3 = [-al -aw ah];
as_body_leg4 = [-al aw ah];
ds_body_leg = [0 0 0];
alphas_body_leg = [0 -pi/2 0];
thetas_body_leg = [0 -pi/2 pi/2];

% transformacija šapa u lokalni koord sustav robota
[T_body_leg1, Ts1] = FK(as_body_leg1, ds_body_leg, thetas_body_leg, alphas_body_leg);
[T_body_leg2, Ts2] = FK(as_body_leg2, ds_body_leg, thetas_body_leg, alphas_body_leg);
[T_body_leg3, Ts3] = FK(as_body_leg3, ds_body_leg, thetas_body_leg, alphas_body_leg);
[T_body_leg4, Ts4] = FK(as_body_leg4, ds_body_leg, thetas_body_leg, alphas_body_leg);

T_body_foot1 = T_body_leg1*T_leg_foot1; % naprijed lijevo
T_body_foot2 = T_body_leg2*T_leg_foot2; % naprijed desno
T_body_foot3 = T_body_leg3*T_leg_foot3; % straga desno
T_body_foot4 = T_body_leg4*T_leg_foot4; % straga lijevo

FK_1 = matlabFunction(T_body_foot1);
FK_2 = matlabFunction(T_body_foot2);
FK_3 = matlabFunction(T_body_foot3);
FK_4 = matlabFunction(T_body_foot4);

%% Global coordinate system to body FK
%transformacija lokalnog koordinatnog sustava u globalni
syms ag dg alphag thetag
T_global = FK(ag,dg,thetag,alphag);  %default koji se definira IMU-om

%transformacija šapa u globalni koordinatni sustav robota
T_global_foot1 = T_global*T_body_foot1; % naprijed lijevo
T_global_foot2 = T_global*T_body_foot2; % naprijed desno
T_global_foot3 = T_global*T_body_foot3; % straga desno
T_global_foot4 = T_global*T_body_foot4; % straga lijevo

XB  = T_global(1:3,4); %pozicija lokalnog koord sustava u globalnom
XB4 = [T_global(1:3,4) T_global(1:3,4) T_global(1:3,4) T_global(1:3,4)]; %pozicija lokalnog x4 radi algoritma
RB  = T_global(1:3,1:3); %orijentacija lokalnog koordinatnog sustava u globalnom

FPL = [T_body_foot1(1:3,4) T_body_foot2(1:3,4) T_body_foot3(1:3,4) T_body_foot4(1:3,4)]; % pozicije šapa u lokalnom 
FPG = [T_global_foot1(1:3,4) T_global_foot2(1:3,4) T_global_foot3(1:3,4) T_global_foot4(1:3,4)]; %pozicije šapa u globalnom

%% Center of body position Jacobian
% svi isti? da!
J1_A = generateJacobian_A(T_body_foot1,q1,q2,q3); % naprijed lijevo
J2_A = generateJacobian_A(T_body_foot2,q4,q5,q6); % naprijed desno
J3_A = generateJacobian_A(T_body_foot3,q7,q8,q9); % straga desno
J4_A = generateJacobian_A(T_body_foot4,q10,q11,q12); % straga lijevo

dFPLdq  = [J1_A zeros(3,9); zeros(3,3) J2_A zeros(3,6); zeros(3,6) J3_A zeros(3,3); zeros(3,9) J4_A];
dLdFPL = FPL/(sqrt(sum(sum(FPL.^2))));
dLdXB4 = (XB4 - FPG)/(sqrt(sum(sum((XB4 - FPG).^2))));

% konačni Jakobijan pozicije lokalnog koordinatnog sustava, ne invertirati jer je simbolički
% JBG_A = dXB4dq = (dLdXB4'*dLdXB4)\dLdXB4'*dLdFPL*dFPLdq; 

%% Center of body rotation Jacobian
% Jakobijan rotacije lokalnog koordinatnog sustava, ne invertirati jer je simbolički
% JBG_B = dRBdq = -(dXB4dq + RB*dFPLdq)*(FPL'*FPL)\FPL'

%% Center of mass coordinate system to body FK
% Pozicija centra mase u lokalnom koordinatnom sustavu i pozicije šapa u
% koordinatnom sustavu centra mase
syms acm dcm alphacm thetacm
T_body_cm = FK(acm,dcm,thetacm,alphacm); % transformacija centra mase u lokalni koordinatni sustav

T_mass_foot1 = T_body_cm\T_body_foot1; % naprijed lijevo
T_mass_foot2 = T_body_cm\T_body_foot2; % naprijed desno
T_mass_foot3 = T_body_cm\T_body_foot3; % straga desno
T_mass_foot4 = T_body_cm\T_body_foot4; % straga lijevo

XML = T_body_cm(1:3,4);
XML4 = [T_body_cm(1:3,4) T_body_cm(1:3,4) T_body_cm(1:3,4) T_body_cm(1:3,4)];

FPM = [T_mass_foot1(1:3,4) T_mass_foot2(1:3,4) T_mass_foot3(1:3,4) T_mass_foot4(1:3,4)];

%% Center of mass position Jacobian
% Jakobijan pozicije centra mase
JM1_A = generateJacobian_A(T_mass_foot1,q1,q2,q3); % naprijed lijevo
JM2_A = generateJacobian_A(T_mass_foot2,q4,q5,q6); % naprijed desno
JM3_A = generateJacobian_A(T_mass_foot3,q7,q8,q9); % straga desno
JM4_A = generateJacobian_A(T_mass_foot4,q10,q11,q12); % straga lijevo

dFPMdq  = [JM1_A zeros(3,9); zeros(3,3) JM2_A zeros(3,6); zeros(3,6) JM3_A zeros(3,3); zeros(3,9) JM4_A];
dLdFPM = FPM/(sqrt(sum(sum(FPM.^2))));
dLdXML4 = (XML4 - FPG)/(sqrt(sum(sum((XML4 - FPG).^2))));

%dXML4dq = (dLdXML4'*dLdXML4)\dLdXML4'*dLdFPM*dFPMdq;

%JMG_A = JBG_A + RB*dXML4dq + dRBdq*XML4;

%% Swing foot Jacobian
% Jakobijan pozicije noge i koja se miče
%JSW_A = dXB4dq + RB*Ji_A + dRBdq*T_global_footi(1:3,4)
