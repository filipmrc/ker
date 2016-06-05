%   Generate required parameters and transformation matrices

syms q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12
%% Generate shoulder to foot FK
%   DH parameters
a1 = 0.0272; a2 = 0.056; d4 = 0.0606;
as_shoulder_foot = [a1 a2 0 0];
ds_shoulder_foot = [0 0 0 d4];
alphas_shoulder_foot = [-pi/2 0 pi/2 0];
thetas_shoulder_foot1 = [q1 q2 pi/2+q3 0];
thetas_shoulder_foot2 = [q4 q5 pi/2+q6 0];
thetas_shoulder_foot3 = [q7 q8 pi/2+q9 0];
thetas_shoulder_foot4 = [q10 q11 pi/2+q12 0];

%   Generate shoulder to foot transformation
T_shoulder_foot1 = FK(as_shoulder_foot, ds_shoulder_foot, thetas_shoulder_foot1, alphas_shoulder_foot);
T_shoulder_foot2 = FK(as_shoulder_foot, ds_shoulder_foot, thetas_shoulder_foot2, alphas_shoulder_foot);
T_shoulder_foot3 = FK(as_shoulder_foot, ds_shoulder_foot, thetas_shoulder_foot3, alphas_shoulder_foot);
T_shoulder_foot4 = FK(as_shoulder_foot, ds_shoulder_foot, thetas_shoulder_foot4, alphas_shoulder_foot);

%% Generate body to shoulder FK
%   Generate body to shoulder transformations
al = 0.073; aw = 0.036; ah = 0;

rot = [0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
T_body_shoulder1 = [1 0 0 al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1]*rot;
T_body_shoulder2 = [1 0 0 al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1]*rot;
T_body_shoulder3 = [1 0 0 -al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1]*rot;
T_body_shoulder4 = [1 0 0 -al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1]*rot;

%% Generate body to foot FK
% Generate body to foot transformation
T_body_foot1 = T_body_shoulder1*T_shoulder_foot1; % naprijed lijevo
T_body_foot2 = T_body_shoulder2*T_shoulder_foot2; % naprijed desno
T_body_foot3 = T_body_shoulder3*T_shoulder_foot3; % straga desno
T_body_foot4 = T_body_shoulder4*T_shoulder_foot4; % straga lijevo

body_foot1 = matlabFunction(T_body_foot1);
body_foot2 = matlabFunction(T_body_foot2);
body_foot3 = matlabFunction(T_body_foot3);
body_foot4 = matlabFunction(T_body_foot4);

%% Misc
%   Some useful positions
stance = [pi/12, -pi/5, pi/2.5, -pi/12, -pi/5, pi/2.5, -pi/12, pi/5, -pi/2.5, pi/12, pi/5, -pi/2.5];
stance2 = [pi/12, pi/5, -pi/2.5, -pi/12, pi/5, -pi/2.5, -pi/12, pi/5, -pi/2.5, pi/12, pi/5, -pi/2.5];
stance3 = [0, pi/5, -pi/2.5, 0, pi/5, -pi/2.5, 0, pi/5, -pi/2.5, 0, pi/5, -pi/2.5];