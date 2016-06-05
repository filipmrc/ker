function [ Q ] = generateQ(q)
%GENERATEQ Generates Q matrix of leg Jacobian matrices
%   Generates Q matrix of leg Jacobian matrices geometrically using only
%   joint positions.
a1 = 0.0272; a2 = 0.056; d4 = 0.0606;
as_shoulder_foot = [a1 a2 0 0];
ds_shoulder_foot = [0 0 0 d4];
alphas_shoulder_foot = [-pi/2 0 pi/2 0];

al = 0.073; aw = 0.036; ah = 0;
T_body_shoulder1 = [1 0 0 al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1]*[0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
T_body_shoulder2 = [1 0 0 al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1]*[0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
T_body_shoulder3 = [1 0 0 -al; 0 1 0 -aw; 0 0 1 ah; 0 0 0 1]*[0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
T_body_shoulder4 = [1 0 0 -al; 0 1 0 aw; 0 0 1 ah; 0 0 0 1]*[0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];
rot = [0 0 1 0; 0 1 0 0; -1 0 0 0; 0 0 0 1];

T0 = T_body_shoulder1*rot;
T01 = T0*DHtransform(as_shoulder_foot(1), ds_shoulder_foot(1), q(1), alphas_shoulder_foot(1));
T02 = T01*DHtransform(as_shoulder_foot(2), ds_shoulder_foot(2), q(2), alphas_shoulder_foot(2));
T03 = T02*DHtransform(as_shoulder_foot(3), ds_shoulder_foot(3), q(3) + pi/2, alphas_shoulder_foot(3))*DHtransform(as_shoulder_foot(4), ds_shoulder_foot(4), 0, alphas_shoulder_foot(4));

R0 = T0(1:3,1:3);
R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3);

O0 = T0(1:3,4);
O01 = T01(1:3,4);
O02 = T02(1:3,4);
O03 = T03(1:3,4);

z0 = R0*[0; 0; 1];
z1 = R01*[0; 0; 1];
z2 = R02*[0; 0; 1];

Jv1=cross(z0, O03 - O0);
Jv2=cross(z1, O03 - O01);
Jv3=cross(z2, O03 - O02);


J1 = T03(1:3,1:3)'*[Jv1 Jv2 Jv3];

T0 = T_body_shoulder2*rot;
T01 = T0*DHtransform(as_shoulder_foot(1), ds_shoulder_foot(1), q(4), alphas_shoulder_foot(1));
T02 = T01*DHtransform(as_shoulder_foot(2), ds_shoulder_foot(2), q(5), alphas_shoulder_foot(2));
T03 = T02*DHtransform(as_shoulder_foot(3), ds_shoulder_foot(3), q(6) + pi/2, alphas_shoulder_foot(3))*DHtransform(as_shoulder_foot(4), ds_shoulder_foot(4), 0, alphas_shoulder_foot(4));

R0 = T0(1:3,1:3);
R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3);

O0 = T0(1:3,4);
O01 = T01(1:3,4);
O02 = T02(1:3,4);
O03 = T03(1:3,4);

z0 = R0*[0; 0; 1];
z1 = R01*[0; 0; 1];
z2 = R02*[0; 0; 1];

Jv1=cross(z0, O03 - O0);
Jv2=cross(z1, O03 - O01);
Jv3=cross(z2, O03 - O02);

J2 = T03(1:3,1:3)'*[Jv1 Jv2 Jv3];

T0 = T_body_shoulder3*rot;
T01 = T0*DHtransform(as_shoulder_foot(1), ds_shoulder_foot(1), q(7), alphas_shoulder_foot(1));
T02 = T01*DHtransform(as_shoulder_foot(2), ds_shoulder_foot(2), q(8), alphas_shoulder_foot(2));
T03 = T02*DHtransform(as_shoulder_foot(3), ds_shoulder_foot(3), q(9) + pi/2, alphas_shoulder_foot(3))*DHtransform(as_shoulder_foot(4), ds_shoulder_foot(4), 0, alphas_shoulder_foot(4));

R0 = T0(1:3,1:3);
R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3);

O0 = T0(1:3,4);
O01 = T01(1:3,4);
O02 = T02(1:3,4);
O03 = T03(1:3,4);

z0 = R0*[0; 0; 1];
z1 = R01*[0; 0; 1];
z2 = R02*[0; 0; 1];

Jv1=cross(z0, O03 - O0);
Jv2=cross(z1, O03 - O01);
Jv3=cross(z2, O03 - O02);

J3 = T03(1:3,1:3)'*[Jv1 Jv2 Jv3];
 
T0 = T_body_shoulder4*rot;
T01 = T0*DHtransform(as_shoulder_foot(1), ds_shoulder_foot(1), q(10), alphas_shoulder_foot(1));
T02 = T01*DHtransform(as_shoulder_foot(2), ds_shoulder_foot(2), q(11), alphas_shoulder_foot(2));
T03 = T02*DHtransform(as_shoulder_foot(3), ds_shoulder_foot(3), q(12) + pi/2, alphas_shoulder_foot(3))*DHtransform(as_shoulder_foot(4), ds_shoulder_foot(4), 0, alphas_shoulder_foot(4));

R0 = T0(1:3,1:3);
R01 = T01(1:3,1:3);
R02 = T02(1:3,1:3);

O0 = T0(1:3,4);
O01 = T01(1:3,4);
O02 = T02(1:3,4);
O03 = T03(1:3,4);

z0 = R0*[0; 0; 1];
z1 = R01*[0; 0; 1];
z2 = R02*[0; 0; 1];

Jv1=cross(z0, O03 - O0);
Jv2=cross(z1, O03 - O01);
Jv3=cross(z2, O03 - O02);

J4 = T03(1:3,1:3)'*[Jv1 Jv2 Jv3];

Q = [J1 zeros(3,9); zeros(3,3) J2 zeros(3,6); zeros(3,6) J3 zeros(3,3); zeros(3,9) J4];
end

