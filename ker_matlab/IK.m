function [ Q ] = IK( w)
%IK Inverse kinematics algorithm for single leg in shoulder frame
a1 = 0.0272; a2 = 0.056; d4 = 0.05056;
global leg_fk
x = -w(3);
y = w(2);
z = w(1);
q = zeros(3,16);

q(1,1:16) = atan2(y,x);

t3_1 = (z^2 + (sqrt(x^2 + y^2)-a1)^2 - d4^2 - a2^2)/(2*a2*d4);
t3_2 = (z^2 + (-sqrt(x^2 + y^2)-a1)^2 - d4^2 - a2^2)/(2*a2*d4);

if abs(t3_1)>1
    t3_1 = 1;
end
if abs(t3_2)>1
    t3_2 = 1;
end

q(3,1) = acos(t3_1);
q(3,2) = acos(t3_2);
q(3,3) = -acos(t3_1);
q(3,4) = -acos(t3_2);
q(3,5) = acos(t3_1);
q(3,6) = acos(t3_2);
q(3,7) = -acos(t3_1);
q(3,8) = -acos(t3_2);
q(3,9) = acos(t3_1);
q(3,10) = acos(t3_2);
q(3,11) = -acos(t3_1);
q(3,12) = -acos(t3_2);
q(3,13) = acos(t3_1);
q(3,14) = acos(t3_2);
q(3,15) = -acos(t3_1);
q(3,16) = -acos(t3_2);

h1 = q(3,1); h2 = q(3,2); h3 = q(3,3); h4 = q(3,4);

A_1 = 2*a1*d4*cos(h1) + 2*a1*a2;
A_2 = 2*a1*d4*cos(h2) + 2*a1*a2;
A_3 = 2*a1*d4*cos(h3) + 2*a1*a2;
A_4 = 2*a1*d4*cos(h4) + 2*a1*a2;

B_1 = -2*a1*d4*sin(h1);
B_2 = -2*a1*d4*sin(h2);
B_3 = -2*a1*d4*sin(h3);
B_4 = -2*a1*d4*sin(h4);

K_1 = x^2 + y^2 + z^2 - a1^2 -d4^2 - a2^2 -2*a2*d4*cos(h1);
K_2 = x^2 + y^2 + z^2 - a1^2 -d4^2 - a2^2 -2*a2*d4*cos(h2);
K_3 = x^2 + y^2 + z^2 - a1^2 -d4^2 - a2^2 -2*a2*d4*cos(h3);
K_4 = x^2 + y^2 + z^2 - a1^2 -d4^2 - a2^2 -2*a2*d4*cos(h4);

q(2,1) = real(acos((2*A_1*K_1 + sqrt(complex((2*A_1*K_1)^2 - 4*(A_1^2 + B_1^2)*...
    (K_1^2 - B_1^2))))/(2*(A_1^2 + B_1^2))));
q(2,2) = real(acos((2*A_2*K_2 + sqrt(complex((2*A_2*K_2)^2 - 4*(A_2^2 + B_2^2)*...
    (K_2^2 - B_2^2))))/(2*(A_2^2 + B_2^2))));
q(2,3) = real(acos((2*A_3*K_3 + sqrt(complex((2*A_3*K_3)^2 - 4*(A_3^2 + B_3^2)*...
    (K_3^2 - B_3^2))))/(2*(A_3^2 + B_3^2))));
q(2,4) = real(acos((2*A_4*K_4 + sqrt(complex((2*A_4*K_4)^2 - 4*(A_4^2 + B_4^2)*...
    (K_4^2 - B_4^2))))/(2*(A_4^2 + B_4^2))));
q(2,5) = real(acos((2*A_1*K_1 - sqrt(complex((2*A_1*K_1)^2 - 4*(A_1^2 + B_1^2)*...
    (K_1^2 - B_1^2))))/(2*(A_1^2 + B_1^2))));
q(2,6) = real(acos((2*A_2*K_2 - sqrt(complex((2*A_2*K_2)^2 - 4*(A_2^2 + B_2^2)*...
    (K_2^2 - B_2^2))))/(2*(A_2^2 + B_2^2))));
q(2,7) = real(acos((2*A_3*K_3 - sqrt(complex((2*A_3*K_3)^2 - 4*(A_3^2 + B_3^2)*...
    (K_3^2 - B_3^2))))/(2*(A_3^2 + B_3^2))));
q(2,8) = real(acos((2*A_4*K_4 - sqrt(complex((2*A_4*K_4)^2 - 4*(A_4^2 + B_4^2)*...
    (K_4^2 - B_4^2))))/(2*(A_4^2 + B_4^2))));

q(2,9) = -q(2,1);
q(2,10) = -q(2,2);
q(2,11) = -q(2,3);
q(2,12) = -q(2,4);
q(2,13) = -q(2,5);
q(2,14) = -q(2,6);
q(2,15) = -q(2,7);
q(2,16) = -q(2,8);
Q = [];
for k = size(q,2):-1:1
    w_k = leg_fk(q(1,k),q(2,k),q(3,k));
    if (norm(w-w_k(1:3,4)',inf) < 1e-6) % TODO: check cutoff
        Q = [Q q(:,k)];
    end
end

end

