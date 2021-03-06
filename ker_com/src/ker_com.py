#!/usr/bin/env python
import serial
import time
import string
import rospy
from std_msgs.msg import String

ser = serial.Serial('/dev/ttyACM0',1000000)
time.sleep(1)

global usporedba
usporedba = ''
global slanje
slanje = ''

rospy.init_node('listener', anonymous=True)
pub = rospy.Publisher('ker/dxl_states', String, queue_size=0)
rate = rospy.Rate(50)

def callback_cmd_pos(data):
	global usporedba
	if (data.data != usporedba):
		ser.write(data.data)
	#time.sleep(0.1)
	#ser.flushOutput()
	usporedba = data.data
	rospy.loginfo("Sent: %s", usporedba)
#	rospy.loginfo("Sent: %s", data.data)
	#poruka = ''
	#poruka = ser.readline()
	#print poruka
	#if len(poruka) >= 10 and len(poruka) <= 60:
	#print poruka
	#pub.publish(poruka)
	

def listener():
	global slanje
	rospy.Subscriber("ker/dxl_cmd_pos", String, callback_cmd_pos)		
	while not rospy.is_shutdown():
		poruka = ''
		poruka = ser.readline()
		if len(poruka) == 37:
			pub.publish(poruka)
		rate.sleep()

if __name__ == '__main__':
	try:
		listener()
	except rospy.ROSInterruptException:
		pass



