#ifndef KER_CONTROL_H_
#define KER_CONTROL_H_

#define NUM_JOINTS_SHOULDER 4
#define NUM_JOINTS_LEG 8
#define NUM_JOINTS 12

#include <ros/ros.h>
#include <std_msgs/Float64MultiArray.h>
#include <sensor_msgs/JointState.h>
#include <actionlib/client/simple_action_client.h>

class Ker
{
private:
  ros::Publisher shoulder_pub, leg_pub;
  ros::Time start_time;

public:
  Ker(ros::NodeHandle n)
  {
    shoulder_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_shoulder_controller/command",1);
    leg_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_leg_controller/command",1);
  }
  void setJoint(std::vector<float> joint_goal);
};
#endif /*KER_CONTROL_H_*/
