function [] = execute(Q)
%EXECUTE Send ROS messages to controller topics
%   Detailed explanation goes here

global lf_shoulder_pub rf_shoulder_pub lb_shoulder_pub rb_shoulder_pub ...
    lf_humerus_pub rf_humerus_pub lb_femur_pub rb_femur_pub ...
    lf_radius_pub rf_radius_pub lb_tibula_pub rb_tibula_pub

    msg = rosmessage(lf_shoulder_pub);
    msg.Data = Q(1);
    send(lf_shoulder_pub, msg);
    
    msg = rosmessage(lf_humerus_pub);
    msg.Data = Q(2);
    send(lf_humerus_pub, msg);
    
    msg = rosmessage(lf_radius_pub);
    msg.Data = Q(3);
    send(lf_radius_pub, msg);
    
    msg = rosmessage(rf_shoulder_pub);
    msg.Data = Q(4);
    send(rf_shoulder_pub, msg);
    
    msg = rosmessage(rf_humerus_pub);
    msg.Data = Q(5);
    send(rf_humerus_pub, msg);
    
    msg = rosmessage(rf_radius_pub);
    msg.Data = Q(6);
    send(rf_radius_pub, msg);
    
    msg = rosmessage(rb_shoulder_pub);
    msg.Data = Q(7);
    send(rb_shoulder_pub, msg);
    
    msg = rosmessage(rb_femur_pub);
    msg.Data = Q(8);
    send(rb_femur_pub, msg);
    
    msg = rosmessage(rb_tibula_pub);
    msg.Data = Q(9);
    send(rb_tibula_pub, msg);
    
    msg = rosmessage(lb_shoulder_pub);
    msg.Data = Q(10);
    send(lb_shoulder_pub, msg);
    
    msg = rosmessage(lb_femur_pub);
    msg.Data = Q(11);
    send(lb_femur_pub, msg);
    
    msg = rosmessage(lb_tibula_pub);
    msg.Data = Q(12);
    send(lb_tibula_pub, msg);
end

