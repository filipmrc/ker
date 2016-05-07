function [ T] = FK( a_i, d_i , theta_i , alpha_i )
%Calculates forward kinematics given the DH parameters in array form.
syms a d theta alph;
T = eye(4);
T_gen=[ cos(theta)  -cos(alph)*sin(theta)  sin(alph)*sin(theta) a*cos(theta) ;
        sin(theta)   cos(alph)*cos(theta) -sin(alph)*cos(theta) a*sin(theta) ;
        0            sin(alph)             cos(alph)            d            ;
        0            0                      0                   1           ];

for cnt= 1 : size(a_i,2)
    Ti{cnt} = subs(T_gen, {'alph' 'theta'  'd'  'a'},{ alpha_i(cnt) theta_i(cnt) d_i(cnt)  a_i(cnt)});
    T = T * subs(T_gen, {'alph' 'theta'  'd'  'a'},{ alpha_i(cnt) theta_i(cnt) d_i(cnt)  a_i(cnt)});
end






end

