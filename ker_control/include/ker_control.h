#ifndef KER_CONTROL_H_
#define KER_CONTROL_H_

#define NUM_JOINTS_SHOULDER 4
#define NUM_JOINTS_LEG 8
#define NUM_JOINTS 12

#define PI 3.14159265359

#include <ros/ros.h>
#include <geometry_msgs/Point.h>
#include <geometry_msgs/Pose.h>
#include <std_msgs/Float64MultiArray.h>
#include <sensor_msgs/JointState.h>
#include <actionlib/client/simple_action_client.h>
#include <Eigen/Core>
#include <Eigen/Dense>
using namespace std;
using namespace Eigen;
//typedef Matrix<float, 3, 1> Vector3f;
//typedef Matrix<float, 6, 1> Vector6f;
//typedef Matrix<float, 12, 1> Vector12f;
//typedef Matrix<float, 4, 4> Matrix4x4f;

class Ker
{
private:
  ros::Publisher shoulder_pub, leg_pub, fk_pub;
  ros::Subscriber joint_states_sub;
  ros::Time start_time;

  sensor_msgs::JointState joint_states;
  int state;
  float a1, a2, d4, al, aw, ah; // treba još a1

  Affine3f T_leg_foot1, T_leg_foot2, T_leg_foot3, T_leg_foot4,
	   T_body_leg1, T_body_leg2, T_body_leg3, T_body_leg4,
	   T_body_foot1, T_body_foot2, T_body_foot3, T_body_foot4;

  void jointStatesCallback(const sensor_msgs::JointStateConstPtr &states)
  {
    joint_states = *states;

    Vector3f q1(joint_states.position[4], joint_states.position[2], joint_states.position[8]),
	     q2(joint_states.position[5], joint_states.position[3], joint_states.position[9]),
	     q3(joint_states.position[6], joint_states.position[1], joint_states.position[11]),
	     q4(joint_states.position[7], joint_states.position[0], joint_states.position[10]);

    T_leg_foot1 = legFK(q1);
    T_leg_foot2 = legFK(q2);
    T_leg_foot3 = legFK(q3);
    T_leg_foot4 = legFK(q4);

    T_body_foot1 = T_body_leg1*T_leg_foot1;
    T_body_foot2 = T_body_leg2*T_leg_foot2;
    T_body_foot3 = T_body_leg3*T_leg_foot3;
    T_body_foot4 = T_body_leg4*T_leg_foot4;

    cout << T_body_foot1.affine() << endl;
  }

public:
  Ker(ros::NodeHandle n)
  {
    shoulder_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_shoulder_controller/command",1);
    fk_pub = n.advertise<geometry_msgs::Pose>("ker/fk",1);
    leg_pub = n.advertise<std_msgs::Float64MultiArray>("ker/ker_leg_controller/command",1);
    joint_states_sub = n.subscribe<sensor_msgs::JointState>("/joint_states", 1, &Ker::jointStatesCallback, this);
    start_time = ros::Time::now();
    state = 0;

    a1 = 0.04 , a2 = 0.05799 , d4 = 0.05958;
    al = 0.07282, aw = 0.036, ah = -0.01;

    //Initialize body to leg matrices
    T_body_leg1 = Translation3f(al,aw,ah)*AngleAxisf(PI/2,Vector3f::UnitY());
    T_body_leg2 = Translation3f(al,-aw,ah)*AngleAxisf(PI/2,Vector3f::UnitY());
    T_body_leg3 = Translation3f(-al,-aw,ah)*AngleAxisf(PI/2,Vector3f::UnitY());
    T_body_leg4 = Translation3f(-al,aw,ah)*AngleAxisf(PI/2,Vector3f::UnitY());

    //cout << T_body_leg1.affine() << endl;
  }
  void setJoint(std::vector<float> joint_goal);

  void legIK(geometry_msgs::Point point);

  Affine3f legFK(Vector3f q);

  void stanceTest(std::vector<float>& goal);
};
#endif /*KER_CONTROL_H_*/
