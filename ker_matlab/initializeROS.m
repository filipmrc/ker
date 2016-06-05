%   Initializes ROS interface

setenv('ROS_MASTER_URI','http://localhost:11311')
rosinit
pause(1);
global lf_shoulder_pub rf_shoulder_pub lb_shoulder_pub rb_shoulder_pub ...
    lf_humerus_pub rf_humerus_pub lb_femur_pub rb_femur_pub ...
    lf_radius_pub rf_radius_pub lb_tibula_pub rb_tibula_pub
    
lf_shoulder_pub = rospublisher('/ker/lf_shoulder_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rf_shoulder_pub = rospublisher('/ker/rf_shoulder_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
lb_shoulder_pub = rospublisher('/ker/lb_shoulder_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rb_shoulder_pub = rospublisher('/ker/rb_shoulder_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);

lf_humerus_pub = rospublisher('/ker/lf_humerus_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rf_humerus_pub = rospublisher('/ker/rf_humerus_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
lb_femur_pub = rospublisher('/ker/lb_femur_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rb_femur_pub = rospublisher('/ker/rb_femur_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);

lf_radius_pub = rospublisher('/ker/lf_radius_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rf_radius_pub = rospublisher('/ker/rf_radius_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
lb_tibula_pub = rospublisher('/ker/lb_tibula_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);
rb_tibula_pub = rospublisher('/ker/rb_tibula_position_controller/command','std_msgs/Float64','IsLatching',true);
pause(0.1);

joint_sub = rossubscriber('/joint_states', rostype.sensor_msgs_JointState);
pause(0.1);

global tftree;
tftree = rostf;