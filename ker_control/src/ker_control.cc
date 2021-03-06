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

Affine3d Ker::globalToBody(Hyperplane<double, 3> plane)
{
  Affine3d T_global_body(Translation3d(0,0,ah));

  //center of body orientation in the global coordinate system from kinematics
  Vector3d n = plane.normal();

  //TODO center of body translation/rotation in the global coordinate system from IMU

  //T_global_body.

  Affine3d l1 = Affine3d(AngleAxisd(-PI/2,Vector3d::UnitY()))*T_leg_foot1,
      l2 = Affine3d(AngleAxisd(-PI/2,Vector3d::UnitY()))*T_leg_foot2,
      l3 = Affine3d(AngleAxisd(-PI/2,Vector3d::UnitY()))*T_leg_foot3,
      l4 = Affine3d(AngleAxisd(-PI/2,Vector3d::UnitY()))*T_leg_foot4;

  return T_global_body;
}

void Ker::jointStateCallback(const sensor_msgs::JointStateConstPtr &states)
{
  joint_states = *states;

  tf::StampedTransform transform_leg1, transform_leg2, transform_leg3, transform_leg4;
  try{
    listener.lookupTransform("/leg_1", "/foot_1",
                             ros::Time(0), transform_leg1);
    listener.lookupTransform("/leg_2", "/foot_2",
                             ros::Time(0), transform_leg2);
    listener.lookupTransform("/leg_3", "/foot_3",
                             ros::Time(0), transform_leg3);
    listener.lookupTransform("/leg_4", "/foot_4",
                             ros::Time(0), transform_leg4);
  }
  catch (tf::TransformException &ex){
    ROS_ERROR("%s",ex.what());
    ros::Duration(1.0).sleep();
  }

  Vector3d q1(joint_states.position[6], joint_states.position[2], joint_states.position[4]),
	q2(joint_states.position[7], joint_states.position[3], joint_states.position[5]),
	q3(joint_states.position[8], joint_states.position[1], joint_states.position[11]),
	q4(joint_states.position[9], joint_states.position[0], joint_states.position[10]);

  Affine3d T_body_knee, T_knee_foot(Translation3d(0,0,-0.03958));
  tf::transformTFToEigen(transform_leg1, T_body_knee);

  T_body_foot1 = T_body_knee*T_knee_foot;

  //T_body_foot1 = T_body_leg1*T_leg_foot1;
  T_body_foot2 = T_body_leg2*T_leg_foot2;
  T_body_foot3 = T_body_leg3*T_leg_foot3;
  T_body_foot4 = T_body_leg4*T_leg_foot4;

  //Take global foot positions from the last iteration
  T_global_foot1 = T_global_body*T_body_foot1;
  T_global_foot2 = T_global_body*T_body_foot2;
  T_global_foot3 = T_global_body*T_body_foot3;
  T_global_foot4 = T_global_body*T_body_foot4;

  Vector3d p1(T_global_foot1(0,3), T_global_foot1(1,3), -T_global_foot1(2,3)),
	p2(T_global_foot2(0,3), T_global_foot2(1,3), -T_global_foot2(2,3)),
	p3(T_global_foot3(0,3), T_global_foot3(1,3), -T_global_foot2(2,3)),
	p4(T_global_foot4(0,3), T_global_foot4(1,3), -T_global_foot4(2,3)), p8(0,0,0);

  Hyperplane<double, 3> platform_plane = Hyperplane<double, 3>::Through (p1,p2,p3);

  T_global_body = globalToBody(platform_plane);

  cout << T_body_foot1.affine() << "\n" << endl;
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
      goal[0] = PI/12;
      goal[1] = -PI/12;
      goal[2] = -PI/12;
      goal[3] = PI/12;
      goal[4] = PI/5;
      goal[5] = -PI/2.5;
      goal[6] = PI/5;
      goal[7] = -PI/2.5;
      goal[8] = PI/5;
      goal[9] = -PI/2.5;
      goal[10] = PI/5;
      goal[11] = -PI/2.5;
      ker.setJoint(goal);
      ros::spinOnce();
      r.sleep();
    }
}

