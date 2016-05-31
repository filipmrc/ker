#include <ros/ros.h>
#include <sstream>
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
#define NUM_JOINTS_LEG 8

class KerPositionInterface : public hardware_interface::RobotHW
{

private:
    ros::Publisher dxl_pub;
    ros::Subscriber dxl_sub;
public:
  KerPositionInterface(ros::NodeHandle n)
 {
    dxl_pub = n.advertise<std_msgs::String>("ker/dxl_cmd_pos",1);
    dxl_sub = n.subscribe<std_msgs::String>("ker/dxl_states", 1, &KerPositionInterface::dataCallback, this);
  }

  void initInterface()
  {
    // connect and register the joint state interface
    hardware_interface::JointStateHandle state_handle_1("humerus_1_joint", &pos[0], &vel[0], &eff[0]);
    jnt_state_interface.registerHandle(state_handle_1);

    hardware_interface::JointStateHandle state_handle_2("humerus_2_joint", &pos[1], &vel[1], &eff[1]);
    jnt_state_interface.registerHandle(state_handle_2);

    hardware_interface::JointStateHandle state_handle_3("radius_1_joint", &pos[2], &vel[2], &eff[2]);
    jnt_state_interface.registerHandle(state_handle_3);

    hardware_interface::JointStateHandle state_handle_4("radius_2_joint", &pos[3], &vel[3], &eff[3]);
    jnt_state_interface.registerHandle(state_handle_4);

    hardware_interface::JointStateHandle state_handle_5("femur_1_joint", &pos[4], &vel[4], &eff[4]);
    jnt_state_interface.registerHandle(state_handle_5);

    hardware_interface::JointStateHandle state_handle_6("femur_2_joint", &pos[5], &vel[5], &eff[5]);
    jnt_state_interface.registerHandle(state_handle_6);

    hardware_interface::JointStateHandle state_handle_7("tibula_1_joint", &pos[6], &vel[6], &eff[6]);
    jnt_state_interface.registerHandle(state_handle_7);

    hardware_interface::JointStateHandle state_handle_8("tibula_2_joint", &pos[7], &vel[7], &eff[7]);
    jnt_state_interface.registerHandle(state_handle_8);

    registerInterface(&jnt_state_interface);

    // connect and register the joint velocity interface
    hardware_interface::JointHandle pos_handle_1(jnt_state_interface.getHandle("humerus_1_joint"), &cmd[0]);
    jnt_pos_interface.registerHandle(pos_handle_1);

    hardware_interface::JointHandle pos_handle_2(jnt_state_interface.getHandle("humerus_2_joint"), &cmd[1]);
    jnt_pos_interface.registerHandle(pos_handle_2);

    hardware_interface::JointHandle pos_handle_3(jnt_state_interface.getHandle("radius_1_joint"), &cmd[2]);
    jnt_pos_interface.registerHandle(pos_handle_3);

    hardware_interface::JointHandle pos_handle_4(jnt_state_interface.getHandle("radius_2_joint"), &cmd[3]);
    jnt_pos_interface.registerHandle(pos_handle_4);

    hardware_interface::JointHandle pos_handle_5(jnt_state_interface.getHandle("femur_1_joint"), &cmd[4]);
    jnt_pos_interface.registerHandle(pos_handle_5);

    hardware_interface::JointHandle pos_handle_6(jnt_state_interface.getHandle("femur_2_joint"), &cmd[5]);
    jnt_pos_interface.registerHandle(pos_handle_6);

    hardware_interface::JointHandle pos_handle_7(jnt_state_interface.getHandle("tibula_1_joint"), &cmd[6]);
    jnt_pos_interface.registerHandle(pos_handle_7);

    hardware_interface::JointHandle pos_handle_8(jnt_state_interface.getHandle("tibula_2_joint"), &cmd[7]);
    jnt_pos_interface.registerHandle(pos_handle_8);

    registerInterface(&jnt_pos_interface);
  }

  void dataCallback(const std_msgs::StringConstPtr &states)
    {


    }

  void getJointStates()
  {


  }

  void setJointPositions(ros::Duration period)
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
  hardware_interface::PositionJointInterface jnt_pos_interface;
  double cmd[8];
  double pos[8];
  double vel[8];
  double eff[8];
};

int main(int argc, char** argv)
{
  ros::init(argc, argv, "ker_joint_position_interface");
  ros::NodeHandle nh;

  KerPositionInterface ker(nh);
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
    ker.setJointPositions(ros::Duration(r));
    ros::spinOnce();
    r.sleep();
  }
}
