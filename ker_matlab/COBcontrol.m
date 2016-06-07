%   Control of center of body position
q = getJointStates(joint_sub);    
q_leg = [q(7) , q(3), q(5), q(8) , q(4), q(6), q(9) , q(2), q(12),q(10), q(1), q(11)]';

goal = [0.01;0.00;0.00;0;0.0;0.0];

T_c1b = body_foot1(q_leg(1), q_leg(2), q_leg(3));
T_c2b = body_foot2(q_leg(4), q_leg(5), q_leg(6));
T_c3b = body_foot3(q_leg(7), q_leg(8), q_leg(9));
T_c4b = body_foot4(q_leg(10), q_leg(11), q_leg(12));

P1 = adj(inv(T_c1b)); P1 = P1(1:3,1:6);
P2 = adj(inv(T_c2b)); P2 = P2(1:3,1:6);
P3 = adj(inv(T_c3b)); P3 = P3(1:3,1:6);
P4 = adj(inv(T_c4b)); P4 = P4(1:3,1:6);

P = [P1;P2;P3;P4];
Q = -generateQ(q_leg);

dw_bb = goal;
pq = (P)\Q;
qa = pinv(pq)*dw_bb;
q = getJointStates(joint_sub);    
execute(q_leg+qa);
