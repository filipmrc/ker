q = getJointStates(joint_sub);
    
q_leg = [q(5) , q(3), q(9), q(6) , q(4), q(10), q(7) , q(2), q(12),q(8), q(1), q(11)];
   
% foot positions in body coordinate frame
T_fb1 = body_foot1(q_leg(1), q_leg(2), q_leg(3));
T_fb2 = body_foot2(q_leg(4), q_leg(5), q_leg(6));
T_fb3 = body_foot3(q_leg(7), q_leg(8), q_leg(9));
T_fb4 = body_foot4(q_leg(10), q_leg(11), q_leg(12));

global_t = getTransform(tftree,'map','odom');
gl_tr = [global_t.Transform.Translation.X, ...
    global_t.Transform.Translation.Y, ...
    global_t.Transform.Translation.Z]';
gl_q = [global_t.Transform.Rotation.W, ...
    global_t.Transform.Rotation.X, ...
    global_t.Transform.Rotation.Y, ...
    global_t.Transform.Rotation.Z];

T_bg = quat2tform(gl_q);
T_bg(1:3,4) = gl_tr;

b_beg = gl_tr;

T_gf1 = T_bg*T_fb1; % naprijed lijevo
T_gf2 = T_bg*T_fb2;% naprijed desno
T_gf3 = T_bg*T_fb3; % straga desno
T_gf4 = T_bg*T_fb4; % straga lijevo

beg = [T_gf1(1:3,4);T_gf2(1:3,4);T_gf3(1:3,4);T_gf4(1:3,4)];

goal = beg  + [0.0 0.00 -0.00 0.01 0.0 0.0 -0.00 -0.0 0.0 0.0 0.0 0.0]';
b_goal = b_beg + [0.0 0.00 0.0]';
for i = 1:100
    iterIK;
    
    cm = [dq(1) dq(4) dq(7) dq(10) dq(2) dq(3) dq(5) dq(6) dq(11) dq(12) dq(8) dq(9)];
    send_msgs(cm,shoulder_pub,leg_pub);
    pause(0.1);
end