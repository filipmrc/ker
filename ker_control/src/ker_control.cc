#include <ker_control.h>

void Ker::setJoint(std::vector<float> joint_goal)
{
  std_msgs::Float64MultiArray leg_joints, shoulder_joints;

  joint_goal.resize(NUM_JOINTS);
  for (int i = 0; i<NUM_JOINTS_SHOULDER; i++)
    {
      shoulder_joints.data.push_back(joint_goal[i]);
    }
  shoulder_pub.publish(shoulder_joints);

  for (int i = NUM_JOINTS_SHOULDER; i<NUM_JOINTS; i++)
    {
      leg_joints.data.push_back(joint_goal[i]);
    }
  leg_pub.publish(leg_joints);
}

int main(int argc, char** argv)
{
  ros::init(argc, argv, "ker_control");
  ros::NodeHandle n;
  ros::Rate r(1);

  Ker ker(n);
  ROS_INFO_STREAM("Control node successfully initialized!");

  std::vector<float> goal(NUM_JOINTS);
  goal[0] = 0;
  goal[1] = 0;
  goal[2] = 0;
  goal[3] = 0;
  goal[4] = 0;
  goal[5] = 1;
  goal[6] = 0;
  goal[7] = 0;
  goal[8] = 0;
  goal[9] = 0;
  goal[10] = 0;
  goal[11] = 0;
  while(ros::ok())
    {
      ker.setJoint(goal);
      ros::spinOnce();
      r.sleep();
    }
}
