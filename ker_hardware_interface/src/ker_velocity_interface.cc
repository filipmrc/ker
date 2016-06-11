#include <ros/ros.h>
#include <sstream>
#include <stdlib.h>
#include <stdio.h>
#include <cstdlib>
#include <std_msgs/String.h>
#include <ros/callback_queue.h>
#include <hardware_interface/joint_command_interface.h>
#include <hardware_interface/joint_state_interface.h>
#include <hardware_interface/robot_hw.h>
#include <joint_limits_interface/joint_limits_interface.h>
#include <joint_limits_interface/joint_limits.h>
#include <joint_limits_interface/joint_limits_urdf.h>
#include <joint_limits_interface/joint_limits_rosparam.h>
#include <controller_manager/controller_manager.h>
#define NUM_JOINTS_LEG 12
#define PI 3.14159265359

using namespace std;
class KerVelocityInterface : public hardware_interface::RobotHW
{

private:
    ros::Publisher dxl_pub;
    ros::Subscriber dxl_sub;
	double position[12];
public:
  KerVelocityInterface(ros::NodeHandle n)
 {
    dxl_pub = n.advertise<std_msgs::String>("ker/dxl_cmd_vel",1);
    dxl_sub = n.subscribe<std_msgs::String>("ker/dxl_states", 1, &KerVelocityInterface::dataCallback, this);
  }

  void initInterface()
  {
    // connect and register the joint state interface
    hardware_interface::JointStateHandle state_handle_1("shoulder_1_joint", &pos[0], &vel[0], &eff[0]);
    jnt_state_interface.registerHandle(state_handle_1);

    hardware_interface::JointStateHandle state_handle_2("humerus_1_joint", &pos[1], &vel[1], &eff[1]);
    jnt_state_interface.registerHandle(state_handle_2);

    hardware_interface::JointStateHandle state_handle_3("radius_1_joint", &pos[2], &vel[2], &eff[2]);
    jnt_state_interface.registerHandle(state_handle_3);

    hardware_interface::JointStateHandle state_handle_4("shoulder_2_joint", &pos[3], &vel[3], &eff[3]);
    jnt_state_interface.registerHandle(state_handle_4);

    hardware_interface::JointStateHandle state_handle_5("humerus_2_joint", &pos[4], &vel[4], &eff[4]);
    jnt_state_interface.registerHandle(state_handle_5);

    hardware_interface::JointStateHandle state_handle_6("radius_2_joint", &pos[5], &vel[5], &eff[5]);
    jnt_state_interface.registerHandle(state_handle_6);

    hardware_interface::JointStateHandle state_handle_7("shoulder_3_joint", &pos[6], &vel[6], &eff[6]);
    jnt_state_interface.registerHandle(state_handle_7);

    hardware_interface::JointStateHandle state_handle_8("femur_2_joint", &pos[7], &vel[7], &eff[7]);
    jnt_state_interface.registerHandle(state_handle_8);

	hardware_interface::JointStateHandle state_handle_9("tibula_2_joint", &pos[8], &vel[8], &eff[8]);
    jnt_state_interface.registerHandle(state_handle_9);

	hardware_interface::JointStateHandle state_handle_10("shoulder_4_joint", &pos[9], &vel[9], &eff[9]);
    jnt_state_interface.registerHandle(state_handle_10);

	hardware_interface::JointStateHandle state_handle_11("femur_1_joint", &pos[10], &vel[10], &eff[10]);
    jnt_state_interface.registerHandle(state_handle_11);

	hardware_interface::JointStateHandle state_handle_12("tibula_1_joint", &pos[11], &vel[11], &eff[11]);
    jnt_state_interface.registerHandle(state_handle_12);

    registerInterface(&jnt_state_interface);

    // connect and register the joint velocity interface
    hardware_interface::JointHandle vel_handle_1(jnt_state_interface.getHandle("shoulder_1_joint"), &cmd[0]);
    jnt_vel_interface.registerHandle(vel_handle_1);

    hardware_interface::JointHandle vel_handle_2(jnt_state_interface.getHandle("humerus_1_joint"), &cmd[1]);
    jnt_vel_interface.registerHandle(vel_handle_2);

    hardware_interface::JointHandle vel_handle_3(jnt_state_interface.getHandle("radius_1_joint"), &cmd[2]);
    jnt_vel_interface.registerHandle(vel_handle_3);

    hardware_interface::JointHandle vel_handle_4(jnt_state_interface.getHandle("shoulder_2_joint"), &cmd[3]);
    jnt_vel_interface.registerHandle(vel_handle_4);

    hardware_interface::JointHandle vel_handle_5(jnt_state_interface.getHandle("humerus_2_joint"), &cmd[4]);
    jnt_vel_interface.registerHandle(vel_handle_5);

    hardware_interface::JointHandle vel_handle_6(jnt_state_interface.getHandle("radius_2_joint"), &cmd[5]);
    jnt_vel_interface.registerHandle(vel_handle_6);

    hardware_interface::JointHandle vel_handle_7(jnt_state_interface.getHandle("shoulder_3_joint"), &cmd[6]);
    jnt_vel_interface.registerHandle(vel_handle_7);

    hardware_interface::JointHandle vel_handle_8(jnt_state_interface.getHandle("femur_2_joint"), &cmd[7]);
    jnt_vel_interface.registerHandle(vel_handle_8);

    hardware_interface::JointHandle vel_handle_9(jnt_state_interface.getHandle("tibula_2_joint"), &cmd[8]);
    jnt_vel_interface.registerHandle(vel_handle_9);

    hardware_interface::JointHandle vel_handle_10(jnt_state_interface.getHandle("shoulder_4_joint"), &cmd[9]);
    jnt_vel_interface.registerHandle(vel_handle_10);

    hardware_interface::JointHandle vel_handle_11(jnt_state_interface.getHandle("femur_1_joint"), &cmd[10]);
    jnt_vel_interface.registerHandle(vel_handle_11);

    hardware_interface::JointHandle vel_handle_12(jnt_state_interface.getHandle("tibula_1_joint"), &cmd[11]);
    jnt_vel_interface.registerHandle(vel_handle_12);


    registerInterface(&jnt_vel_interface);
  }

  void dataCallback(const std_msgs::StringConstPtr &states)
    {		
		int i = 0;
		std::string poruka, data;
		poruka = states->data.c_str();
		for (i = 0; i < 12; i++){
			data = poruka.substr(3*i,3);
			position[i] = atof(data.c_str())*double(PI*300/(180*1023)) - double(PI*150/180);
		}
    }

  void getJointStates()
  {	
	int i = 0;
	
	for (i = 0; i < 12; i++){
		pos[i] = position[i];	
		vel[i] = 0;
		eff[i] = 0;
	}
  }

  void setJointVelocities(ros::Duration period)
  {
    std::ostringstream strs;
    for(int i = 0; i<NUM_JOINTS_LEG; i++)
      {
	strs << cmd[i] ;
      }
    std::string str = strs.str();
    std_msgs::String msg;
    msg.data = str;
    dxl_pub.publish(msg);

  }


private:
  hardware_interface::JointStateInterface jnt_state_interface;
  hardware_interface::VelocityJointInterface jnt_vel_interface;
  double cmd[12];
  double pos[12];
  double vel[12];
  double eff[12];
};

int main(int argc, char** argv)
{
  ros::init(argc, argv, "ker_joint_velocity_interface");
  ros::NodeHandle nh;

  KerVelocityInterface ker(nh);
  ker.initInterface();

  ros::CallbackQueue my_callback_queue;
  nh.setCallbackQueue(&my_callback_queue);

  ros::AsyncSpinner spinner(0, &my_callback_queue);
  ros::Rate r(50);

  spinner.start();

  controller_manager::ControllerManager cm(&ker,nh);

  while(ros::ok())
  {
    ker.getJointStates();
    cm.update(ros::Time::now(), ros::Duration(r));
    ker.setJointVelocities(ros::Duration(r));
    ros::spinOnce();
    r.sleep();
  }
}
