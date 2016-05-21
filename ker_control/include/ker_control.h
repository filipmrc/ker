#ifndef KER_CONTROL_H_
#define KER_CONTROL_H_

#define NUM_JOINTS_SHOULDER 4
#define NUM_JOINTS_LEG 8
#define NUM_JOINTS 12

#define PI 3.14159265359

#include <ros/ros.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose.h>
#include <geometry_msgs/Transform.h>
#include <std_msgs/Float64MultiArray.h>
#include <sensor_msgs/JointState.h>
#include <actionlib/client/simple_action_client.h>
#include <Eigen/Core>
#include <Eigen/Dense>
#include <Eigen/Geometry>
#include <tf/transform_listener.h>
#include <tf_conversions/tf_eigen.h>
using namespace std;
using namespace Eigen;
//typedef Matrix<float, 3, 1> Vector3f;
//typedef Matrix<float, 6, 1> Vector6f;
//typedef Matrix<float, 12, 1> Vector12f;
typedef Matrix<float, 3, 4> Matrix3x4f;

class Ker
{
private:
  ros::Publisher shoulder_pub, leg_pub, fk_pub;
  ros::Subscriber joint_states_sub;
  ros::Time start_time;
  tf::TransformListener listener;

  sensor_msgs::JointState joint_states;
  int state;
  double a1, a2, d4, al, aw, ah; // treba još a1

  Affine3d T_leg_foot1, T_leg_foot2, T_leg_foot3, T_leg_foot4,
	   T_body_leg1, T_body_leg2, T_body_leg3, T_body_leg4,
	   T_body_foot1, T_body_foot2, T_body_foot3, T_body_foot4,
	   T_global_body, T_global, T_global_foot1, T_global_foot2,
	   T_global_foot3, T_global_foot4;

  Vector3d XB;

  MatrixXd XB4;

  void jointStateCallback(const sensor_msgs::JointStateConstPtr &states);

public:
  Ker(ros::NodeHandle n)
  {
    shoulder_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_shoulder_controller/command",1);
    fk_pub = n.advertise<geometry_msgs::Pose>("ker/fk",1);
    leg_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_leg_controller/command",1);
    joint_states_sub = n.subscribe<sensor_msgs::JointState>("/joint_states", 1, &Ker::jointStateCallback, this);
    start_time = ros::Time::now();
    state = 0;

    a1 = 0.04 , a2 = 0.05799 , d4 = 0.05958;
    al = 0.07282, aw = 0.036, ah = -0.01;

    //Initialize body to leg matrices
    T_body_leg1 = Translation3d(al,aw,ah);
    T_body_leg2 = Translation3d(al,-aw,ah);
    T_body_leg3 = Translation3d(-al,-aw,ah);
    T_body_leg4 = Translation3d(-al,aw,ah);

    //T_global_body = Affine3d::Identity();//globalToBody();

    //XB << T_global_body(0,3),T_global_body(1,3),T_global_body(2,3);
    //XB4 << XB, XB ,XB ,XB;

  }
  void setJoint(std::vector<float> joint_goal);

  void legIK(geometry_msgs::Point point);

  Affine3d legToFoot(Vector3f q);

  Affine3d globalToBody(Hyperplane<double, 3> plane);

  void stanceTest(std::vector<float>& goal);
};
#endif /*KER_CONTROL_H_*/
