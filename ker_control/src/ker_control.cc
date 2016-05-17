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

void Ker::stanceTest(std::vector<float>& goal)
{
  goal.resize(NUM_JOINTS);
  goal[0] = PI/10;
  goal[1] = -PI/10;
  goal[2] = -PI/10;
  goal[3] = PI/10;
  goal[4] = -PI/6;
  goal[5] = PI/3;
  goal[6] = PI/6;
  goal[7] = -PI/3;
  goal[8] = PI/6;
  goal[9] = -PI/3;
  goal[10] = -PI/6;
  goal[11] = PI/3;

}

// Banalan primjer periodičkog kretanja zglobova
void Ker::walkingGait(std::vector<float> &goal, int i)
{
  goal.resize(NUM_JOINTS);
  double T=100;

  if (i % 100 == 0)
    {
      state++;
      state%=4;
    }

  state = 0;


  switch(state)
  {
    case(0):
      goal[4] = sin(2*PI*double(i/T));
      goal[5] = sin(2*PI*double(i/T) - PI/4);
      break;
    case (2):
      goal[6] = sin(2*PI*double(i/T) + PI/2);
      goal[7] = sin(2*PI*double(i/T) + PI/2 -PI/4);
      break;
    case (1):
      goal[8] = sin(2*PI*double(i/T) + 3*PI/2);
      goal[9] = sin(2*PI*double(i/T) + 3*PI/2 - PI/4);
      break;
    case (3):
      goal[10] = sin(2*PI*double(i/T) + PI/2);
      goal[11] = sin(2*PI*double(i/T) + PI/2 - PI/4);
      break;
    }
}

/*void Ker::legIK(geometry_msgs::Point pnt)
{

}*/

int main(int argc, char** argv)
{
  ros::init(argc, argv, "ker_control");
  ros::NodeHandle n;
  ros::Rate r(50);

  Ker ker(n);
  ROS_INFO_STREAM("Control node successfully initialized!");

  std::vector<float> goal(NUM_JOINTS);
  int i = 0;
  while(ros::ok())
    {
      //ker.walkingGait(goal, i);
      ker.stanceTest(goal);
      ker.setJoint(goal);
      i++;
      ros::spinOnce();
      r.sleep();
    }
}

