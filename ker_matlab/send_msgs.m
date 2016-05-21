function [] = send_msgs(Q, shoulder_pub, leg_pub)
%SENDMSG Summary of this function goes here
%   Detailed explanation goes here
    msg = rosmessage(shoulder_pub);
    msgd = rosmessage('std_msgs/MultiArrayDimension');
    msgd.Size = 4;
    msgd.Stride = 1;
    msg.Layout.Dim(1) = msgd;
    msg.Data = Q(1:4);
    send(shoulder_pub, msg);
    
    
    msg = rosmessage(leg_pub);
    msgd.Size = 8;
    msgd.Stride = 1;
    msg.Layout.Dim(1) = msgd;
    msg.Data = Q(5:end);
    send(leg_pub, msg);
    pause(0.1);
end

