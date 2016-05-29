#!/usr/bin/env python
import serial
import time
import string
import rospy
from std_msgs.msg import String

ser = serial.Serial('/dev/ttyACM0',9600)
time.sleep(1)

def callback_rpicm(data):
	k = 0
	if ser.writable():
		ser.write(data.data)

	if ser.readable():
		poruka = ser.readline()
		for znak in poruka:
			if znak.isalnum():
				k += 1
		rospy.loginfo("Data: %s", poruka[:k])
		k = 0

	

def listener():
	rospy.init_node('rpicm', anonymous=True)

	rospy.Subscriber("ker_info", String, callback_rpicm)
	
	rospy.spin()

if __name__ == '__main__':
	listener()





