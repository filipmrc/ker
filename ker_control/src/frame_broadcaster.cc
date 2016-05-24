#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/Pose.h>
#include <gazebo_msgs/LinkStates.h>

geometry_msgs::Pose odom;

void gazeboCallback(const gazebo_msgs::LinkStatesConstPtr &states)
{
  odom = states->pose[1];
}

int main(int argc, char** argv){
  ros::init(argc, argv, "my_tf_broadcaster");
  ros::NodeHandle n;
  ros::Subscriber ground_truth_sub = n.subscribe<gazebo_msgs::LinkStates>("/gazebo/link_states",1,gazeboCallback);

  tf::TransformBroadcaster br;
  tf::Transform transform;

  float al = 0.073, aw = 0.036, ah = -0.00, dl = 0.04 + 0.018;

  ros::Rate rate(30.0);
  while (n.ok()){
    transform.setOrigin( tf::Vector3(al, aw, ah) );
    transform.setRotation( tf::Quaternion(0, 0, 0, 1) );
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "body", "leg_1"));

    transform.setOrigin( tf::Vector3(al, -aw, ah) );
    transform.setRotation( tf::Quaternion(0, 0, 0, 1) );
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "body", "leg_2"));

    transform.setOrigin( tf::Vector3(-al + dl, -aw, ah) );
    transform.setRotation( tf::Quaternion(0, 0, 0, 1) );
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "body", "leg_3"));

    transform.setOrigin( tf::Vector3(-al + dl, aw, ah) );
    transform.setRotation( tf::Quaternion(0, 0, 0, 1) );
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "body", "leg_4"));

    transform.setOrigin( tf::Vector3(odom.position.x, odom.position.y, odom.position.z));
    transform.setRotation(tf::Quaternion(odom.orientation.x,odom.orientation.y,odom.orientation.z,odom.orientation.w));
    br.sendTransform(tf::StampedTransform(transform, ros::Time::now(), "map", "odom"));

    ros::spinOnce();
    rate.sleep();
  }
  return 0;
};
