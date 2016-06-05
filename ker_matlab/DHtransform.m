function [ T_gen ] = DHtransform( a_i, d_i , theta_i , alpha_i  )
%DHTRANSFORM Homogenous transformation from DH parameters
%   Detailed explanation goes here

T_gen=[ cos(theta_i)  -cos(alpha_i)*sin(theta_i)  sin(alpha_i)*sin(theta_i) a_i*cos(theta_i) ;
        sin(theta_i)   cos(alpha_i)*cos(theta_i) -sin(alpha_i)*cos(theta_i) a_i*sin(theta_i) ;
        0            sin(alpha_i)             cos(alpha_i)            d_i            ;
        0            0                      0                   1           ];

end

