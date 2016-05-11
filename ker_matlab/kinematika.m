%% Generate leg to foot FK
syms  a1 a2 a3  d1 d4 q1 q2 q3
as_leg_foot = [a1 a2 0 0];
ds_leg_foot = [0 0 0 d4];
alphas_leg_foot = [-pi/2 0 pi/2 0];
thetas_leg_foot = [q1 q2 pi/2+q3 0];

T_leg_foot = simplify(FK(as_leg_foot, ds_leg_foot, thetas_leg_foot, alphas_leg_foot));
J = simplify(generateJacobian(T_leg_foot));
Tf_leg = matlabFunction(T_leg_foot);

%% Generate body to leg FK
syms al aw ah
as_body_leg1 = [al aw ah];
as_body_leg2 = [al -aw ah];
as_body_leg3 = [-al -aw ah];
as_body_leg4 = [-al aw ah];
ds_body_leg = [0 0 0];
alphas_body_leg = [0 -pi/2 0];
thetas_body_leg = [0 -pi/2 pi/2];

% transformacija šapa u koordinatni sustav robota
T_body_leg1 = simplify(FK(as_body_leg1, ds_body_leg, thetas_body_leg, alphas_body_leg));
T_body_leg2 = simplify(FK(as_body_leg2, ds_body_leg, thetas_body_leg, alphas_body_leg));
T_body_leg3 = simplify(FK(as_body_leg3, ds_body_leg, thetas_body_leg, alphas_body_leg));
T_body_leg4 = simplify(FK(as_body_leg4, ds_body_leg, thetas_body_leg, alphas_body_leg));

T_body_foot1 = T_body_leg1*T_leg_foot;
T_body_foot2 = T_body_leg2*T_leg_foot;
T_body_foot3 = T_body_leg3*T_leg_foot;
T_body_foot4 = T_body_leg4*T_leg_foot;

FK_1 = matlabFunction(T_body_foot1);
FK_2 = matlabFunction(T_body_foot2);
FK_3 = matlabFunction(T_body_foot3);
FK_4 = matlabFunction(T_body_foot4);

%% Global coordinate system to body FK
%syms xx xy xz yx yy yz zx zy zz p1 p2 p3
%transformacija koordinatnog sustava robota u globalni
T_global = eye(4); %default koji se definira IMU-om

XB_4(:,1:4) = T_global(1:3,4); %pozicija centra tijela/mase u globalnom sustavu
RB  = T_global(1:3,1:3); %rotacija koordinatnog sustava centra mase

%% Generate Jacobian
% svi isti? da!
J1 = generateJacobian(T_body_foot1);
J2 = generateJacobian(T_body_foot2);
J3 = generateJacobian(T_body_foot3);
J4 = generateJacobian(T_body_foot4);
