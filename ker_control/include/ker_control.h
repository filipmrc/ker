#ifndef KER_CONTROL_H_
#define KER_CONTROL_H_

#define NUM_JOINTS_SHOULDER 4
#define NUM_JOINTS_LEG 8
#define NUM_JOINTS 12

#define PI 3.14159265359

#include <ros/ros.h>
#include <geometry_msgs/Point.h>
#include <std_msgs/Float64MultiArray.h>
#include <sensor_msgs/JointState.h>
#include <actionlib/client/simple_action_client.h>
#include <Eigen/Core>
using namespace std;
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
    start_time = ros::Time::now();
  }
  void setJoint(std::vector<float> joint_goal);

  void walkingGait(std::vector<float> &goal, int i);

  void legIK(geometry_msgs::Point point);
};
#endif /*KER_CONTROL_H_*/
