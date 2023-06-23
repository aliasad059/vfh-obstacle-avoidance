#!/usr/bin/python3

import rospy
from sensor_msgs.msg import LaserScan
from scipy.signal import argrelmin
import numpy as np
from turtlebot3_obstacle_avoidance.srv import ObstacleAvoidanceService, ObstacleAvoidanceServiceResponse


class VFH():
    def __init__(self, vfh_config) -> None:

        self.destination = vfh_config['destination']
        self.a = vfh_config['a']
        self.b = vfh_config['b']
        self.smoothing_factor = vfh_config['smoothing_factor']
        self.sector_size = vfh_config['sector_size']
        self.threshold = vfh_config['threshold']

        self.histogram_field_vector = None

        self.obstacle_avoidance_service = rospy.Service('vfh_obstacle_avoidance', ObstacleAvoidanceService, self.obstacle_avoidance_callback)
        self.scan_sub = rospy.Subscriber('/scan', LaserScan, self.scan_callback)
    
    def obstacle_avoidance_callback(self):
        response = ObstacleAvoidanceServiceResponse()
        response.goal_angle = self.find_best_direction()
        return response

    def scan_callback(self, msg):
        ranges = np.array(msg.ranges)
        angles = np.arange(msg.angle_min, msg.angle_max, msg.angle_increment)
        histogram_field_vector = self.calculate_histogram_field_vector(ranges, angles)
        self.histogram_field_vector = self.smooth_histogram(histogram_field_vector)
    
    def calculate_histogram_field_vector(self, ranges, angles):
        num_sectors = int(360 / self.sector_size)
        sector_histogram = np.zeros(num_sectors)
        
        for i, distance in enumerate(ranges):
            if np.isnan(distance) or np.isinf(distance):
                continue
            
            sector_index = int((np.degrees(angles[i]) + 180) / self.sector_size)
            certainty = 1 # TODO: maybe we need to calculate as vff does
            obstacle_presence = certainty ** 2 * (self.a - self.b * distance) # TODO: tune a and b as the obstacle presence would not be negative anymore
            sector_histogram[sector_index] += obstacle_presence
        
        return sector_histogram
    
    def smooth_histogram(self, histogram):
        smoothed_histogram = np.zeros_like(histogram)
        
        smoothing_window = 2 * self.smoothing_factor + 1
        weights =  np.concatenate((np.arange(1, self.smoothing_factor + 1), np.arange(self.smoothing_factor + 1, 0, -1))) / smoothing_window
        n = len(histogram)

        for i in range(n):
            indices = [(i - self.smoothing_factor + j) % n for j in range(smoothing_window)]
            smoothed_histogram[i] = np.dot(histogram[indices], weights)

        return smoothed_histogram
    
    def calculate_goal_sector(self):
        current_position = np.array([self.current_x, self.current_y])
        goal_direction = np.array([self.destination[0] - current_position[0], self.destination[1] - current_position[1]])
        goal_angle = np.arctan2(goal_direction[1], goal_direction[0])
        
        goal_angle_deg = np.degrees(goal_angle) % 360
        
        goal_sector = int(goal_angle_deg / self.sector_size)
        
        return goal_sector

    def find_best_direction(self):
        troughs = argrelmin(self.histogram_field_vector)[0]
        
        if len(troughs) > 0:
            eligible_troughs = [trough for trough in troughs if self.histogram_field_vector[trough] < self.threshold]
            
            if len(eligible_troughs) > 0:
                goal_sector = self.calculate_goal_sector()
                if goal_sector in eligible_troughs:
                    return goal_sector
                else:
                    return min(eligible_troughs, key=lambda t: abs(t - self.destination)) # TODO: here we should find the nearest vally to goal and select the suitable sector
        
        # If no eligible troughs, choose the peak as the direction
        return np.argmax(self.histogram_field_vector)
    
    def run(self):
        rospy.spin()

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
    except rospy.ROSInterruptException:
        pass
