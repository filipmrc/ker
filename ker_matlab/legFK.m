function T_shoulder_foot1 = legFK(q1,q2,q3)
%LEGFK
%    T_SHOULDER_FOOT1 = LEGFK(Q1,Q2,Q3)

%    This function was generated by the Symbolic Math Toolbox version 6.2.
%    08-Jun-2016 10:05:42

t2 = cos(q1);
t3 = pi.*(1.0./2.0);
t4 = q3+t3;
t5 = cos(q2);
t6 = sin(t4);
t7 = cos(t4);
t8 = sin(q2);
t9 = sin(q1);
T_shoulder_foot1 = reshape([t2.*t5.*t7-t2.*t6.*t8,t5.*t7.*t9-t6.*t8.*t9,-t5.*t6-t7.*t8,0.0,-t9,t2,0.0,0.0,t2.*t5.*t6+t2.*t7.*t8,t5.*t6.*t9+t7.*t8.*t9,t5.*t7-t6.*t8,0.0,t2.*(1.7e1./6.25e2)+t2.*t5.*(7.0./1.25e2)+t2.*t5.*t6.*6.06e-2+t2.*t7.*t8.*6.06e-2,t9.*(1.7e1./6.25e2)+t5.*t9.*(7.0./1.25e2)+t5.*t6.*t9.*6.06e-2+t7.*t8.*t9.*6.06e-2,t8.*(-7.0./1.25e2)+t5.*t7.*6.06e-2-t6.*t8.*6.06e-2,1.0],[4, 4]);
