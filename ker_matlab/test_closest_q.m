rosshutdown;
clear shoulder_pub, leg_pub;
initialize_ros_interface;


q0 = [0,-pi/6,pi/3]';
u = 1
Q = [q0(1), 0, 0, 0, q0(2), q0(3), 0, 0, 0, 0, 0, 0];
T_ = leg_fk(q0(1),q0(2),q0(3));
w0 = T_(1:3,4);

Mask = [0  0 1 0
        0  1 0 0
       -1  0 0 0
        0  0 0 1];
T = Mask*T_;
w0_tf = T(1:3,4); 
send_msgs(Q,shoulder_pub,leg_pub);

w1 = [0.10, 0, 0.02];
q1 = IK_mex(w1);
q1_closest = closest_q(q0,q1);
u = 2;
Q = [q1_closest(1), 0, 0, 0, q1_closest(2), q1_closest(3), 0, 0, 0, 0, 0, 0];
send_msgs(Q,shoulder_pub,leg_pub);

Q = [q0(1), 0, 0, 0, q0(2), q0(3), 0, 0, 0, 0, 0, 0];
send_msgs(Q,shoulder_pub,leg_pub);
pause(1);
for i = 1:3
    w2 = w0 + [-0.01*i, 0 , 0.0*i]';
    q2 = IK_mex(w2');
    if(i == 1)
        q2_closest = closest_q(q0,q2);
    else
        q2_closest = closest_q(q2_,q2);
    end
    q2_ = q2_closest;
    Q = [q2_closest(1), 0, 0, 0, q2_closest(2), q2_closest(3), 0, 0, 0, 0, 0, 0];
    send_msgs(Q,shoulder_pub,leg_pub);
end

wB = w2 + [0.03, 0, 0]';
qB = closest_q(q2_,IK_mex(wB'));

for i = 1:3
    w3 = w2 + [0.01*i, 0 , 0.01*i]';
    q3 = IK_mex(w3');
    if(i == 1)
        q3_closest = closest_q(q2_,q3);
    else
        q3_closest = closest_q(q3_,q3);
    end
    q3_ = q3_closest;
    Q = [q3_closest(1), 0, 0, 0, q3_closest(2), q3_closest(3), 0, 0, 0, 0, 0, 0];
    send_msgs(Q,shoulder_pub,leg_pub);
end

q_spline = interpolate([q0,qB,q3_]);
Q = [q0(1), 0, 0, 0, q0(2), q0(3), 0, 0, 0, 0, 0, 0];
send_msgs(Q,shoulder_pub,leg_pub);
pause(1);
for j = 1:size(q_spline,2)
    Q = [q_spline(1,j), 0, 0, 0, q_spline(2,j), q_spline(3,j), 0, 0, 0, 0, 0, 0];
    send_msgs(Q,shoulder_pub,leg_pub);
end
    