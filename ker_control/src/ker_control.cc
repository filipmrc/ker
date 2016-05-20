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

Affine3f Ker::legFK(Vector3f q)
{
  Affine3f fk;

  fk(0,0) = cos(q(0))*cos(q(1))*cos(PI/2 + q(2)) - cos(q(0))*sin(q(1))*sin(PI/2 + q(2));
  fk(0,1) = -sin(q(0));
  fk(0,2) = cos(q(0))*cos(q(1))*sin(PI/2 + q(2)) + cos(q(0))*cos(PI/2 + q(2))*sin(q(1));
  fk(0,3) = d4*(cos(q(0))*cos(q(1))*sin(PI/2 + q(2)) + cos(q(0))*cos(PI/2 + q(2))*sin(q(1))) + a1*cos(q(0)) + a2*cos(q(0))*cos(q(1));

  fk(1,0) = cos(q(1))*cos(PI/2 + q(2))*sin(q(0)) - sin(q(0))*sin(q(1))*sin(PI/2 + q(2));
  fk(1,1) = cos(q(0));
  fk(1,2) = cos(q(1))*sin(q(0))*sin(PI/2 + q(2)) + cos(PI/2 + q(2))*sin(q(0))*sin(q(1));
  fk(1,3) = d4*(cos(q(1))*sin(q(0))*sin(PI/2 + q(2)) + cos(PI/2 + q(2))*sin(q(0))*sin(q(1))) + a1*sin(q(0)) + a2*cos(q(1))*sin(q(0));

  fk(2,0) = - cos(q(1))*sin(PI/2 + q(2)) - cos(PI/2 + q(2))*sin(q(1));
  fk(2,1) = 0;
  fk(2,2) = cos(q(1))*cos(PI/2 + q(2)) - sin(q(1))*sin(PI/2 + q(2));
  fk(2,3) = d4*(cos(q(1))*cos(PI/2 + q(2)) - sin(q(1))*sin(PI/2 + q(2))) - a2*sin(q(1));

  fk(3,0) = 0;
  fk(3,1) = 0;
  fk(3,2) = 0;
  fk(3,3) = 1;

  geometry_msgs::Pose noga;
  noga.position.x = fk(0,3); noga.position.y = fk(1,3); noga.position.z = fk(2,3);
  fk_pub.publish(noga);
  return fk;
}
int main(int argc, char** argv)
{
  ros::init(argc, argv, "ker_control");
  ros::NodeHandle n;
  ros::Rate r(50);

  Ker ker(n);
  ROS_INFO_STREAM("Control node successfully initialized!");
  std::vector<float> goal(NUM_JOINTS);
  //ker.walkingGait(goal, i);

  while(ros::ok())
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
      ker.setJoint(goal);
      ros::spinOnce();
      r.sleep();
    }
}

