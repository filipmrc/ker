#include "ros/ros.h"
#include "std_msgs/String.h"
#include <sstream>

int main(int argc, char **argv){

	ros::init(argc, argv, "ker_info");

	ros::NodeHandle n;

	ros::Publisher ker_info_pub = n.advertise<std_msgs::String>("ker_info", 0);

	ros::Rate loop_rate(10);

	int i = 0;

	while (ros::ok()){

		std_msgs::String msg;

		std::stringstream ss;
		ss << i;
		msg.data = ss.str();

		ROS_INFO("%s", msg.data.c_str());

		ker_info_pub.publish(msg);

		ros::spinOnce();

		loop_rate.sleep();
		i += 50;
		if (i >= 1023){
			i = 0;		
		}
	}

	return 0;
}
