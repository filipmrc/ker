setenv('ROS_MASTER_URI','http://localhost:11311')
rosinit

leg_pub = rospublisher('/ker/ker_leg_controller/command','std_msgs/Float64MultiArray','IsLatching',true);
pause(2);
shoulder_pub = rospublisher('/ker/ker_shoulder_controller/command','std_msgs/Float64MultiArray','IsLatching',true);
pause(2);