function [] = send_msgs(input)
%SENDMSG Summary of this function goes here
%   Detailed explanation goes here
shoulder_pub = rospublisher('/ker/ker_shoulder_controller/command','std_msgs/Float64MultiArray');
msg = rosmessage(shoulder_pub);
msg.Data = input(1:4);
send(shoulder_pub, msg);

leg_pub = rospublisher('/ker/ker_leg_controller/command','std_msgs/Float64MultiArray');
msg = rosmessage(leg_pub);
msg.Data = input(5:end);
send(leg_pub, msg);
end

