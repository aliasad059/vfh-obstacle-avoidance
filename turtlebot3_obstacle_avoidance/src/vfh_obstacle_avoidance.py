#!/usr/bin/python3

import tf
import rospy
from geometry_msgs.msg import Twist
from sensor_msgs.msg import LaserScan
from nav_msgs.msg import Odometry
import math
from scipy.signal import argrelmin
import numpy as np


class VFH():
    def __init__(self, vfh_config) -> None:

        self.destination = vfh_config['destination']
        self.a = vfh_config['a']
        self.b = vfh_config['b']
        self.smoothing_factor = vfh_config['smoothing_factor']
        self.sector_size = vfh_config['sector_size']
        self.threshold = vfh_config['threshold']


if __name__ == "__main__":
    try:
        config = {
            'destination' : [-7, 13],
            'a' : 1,
            'b' : 0.25, 
            'smoothing_factor': 2,
            'sector_size': 5,
            'threshold':1.2
        }
        vfh_node = VFH(vfh_config=config)
        vfh_node.run()
        rospy.spin()
    except rospy.ROSInterruptException:
        pass
