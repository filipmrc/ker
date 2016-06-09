#!/usr/bin/env python
import serial
import time
import string
import rospy
from std_msgs.msg import String

ser = serial.Serial('/dev/ttyUSB0',115200)
time.sleep(1)

def dxl_states():
	pub = rospy.Publisher('ker/imu', String, queue_size=0)
	rate = rospy.Rate(100)
	poruka = ''
	while 1:
		poruka = ''
		poruka = ser.readline()
		if len(poruka) >= 5 and len(poruka) <= 35:
			print poruka
			pub.publish(poruka)
		

if __name__ == '__main__':
	rospy.init_node('rpicm_imu', anonymous=True)	
	while not rospy.is_shutdown():
		dxl_states()



