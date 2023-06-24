#!/usr/bin/python3

import rospy
from sensor_msgs.msg import LaserScan
from scipy.signal import argrelmin
import numpy as np
from turtlebot3_obstacle_avoidance.srv import ObstacleAvoidanceService, ObstacleAvoidanceServiceResponse
import math

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
        response.goal_angle = self.find_steering_direction()
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
    
    def get_goal_sector(self):
        current_position = np.array([self.current_x, self.current_y])
        goal_direction = np.array([self.destination[0] - current_position[0], self.destination[1] - current_position[1]])
        goal_angle = np.arctan2(goal_direction[1], goal_direction[0])
        
        goal_angle_deg = np.degrees(goal_angle) % 360
        
        goal_sector = int(goal_angle_deg / self.sector_size)
        
        return goal_sector
    
    def get_candidate_valleys(self):
        valleys_idx = []
        for i in range(len(self.histogram_field_vector)):
            if self.histogram_field_vector[i] < self.VFH_THRESHOLD:
                valleys_idx.append(i)
            
        valleys = []
        candidate_valley = []

        i = 0
        while i < len(valleys_idx):
            while i < len(valleys_idx) and valleys_idx[i] == (valleys_idx[i-1])%len(self.histogram_field_vector) + 1:
                candidate_valley.append(valleys_idx[i])
                i += 1
            
            if len(candidate_valley) > 0:
                valleys.append(deepcopy(candidate_valley))
                candidate_valley.clear()
                if i >= len(valleys_idx):
                    break
            candidate_valley.append(valleys_idx[i])
            i += 1
        
        if len(valleys) >= 2:
            val_begin = valleys[0]
            val_end = valleys[len(valleys)-1]
            if (val_end[len(val_end)-1] + 1)%len(self.histogram_field_vector) == val_begin[0]:
                val_begin = val_end + val_begin  
                valleys[0] = val_begin
                valleys.pop(len(valleys)-1)
        return valleys
    
    def find_steering_direction(self):
        valleys = self.get_candidate_valleys()
        
        goal_sector = self.get_goal_sector()
        
        min_distance = np.inf
        nearest_valley = None
        kn = None
        for candidate_valley in valleys:
            if goal_sector in candidate_valley:
                return math.radians(goal_sector * self.sector_size) # goal sector is in a candidate valley
            
            distances = np.abs(np.array(candidate_valley) - goal_sector)
            min_idx = np.argmin(distances)
            if distances[min_idx] < min_distance:
                min_distance = distances[min_idx]
                nearest_valley = candidate_valley
                kn = candidate_valley[min_idx]
        
        if len(nearest_valley) > self.VFH_S_MAX: # wide candidate valley
            kf = (kn + self.VFH_S_MAX) % (360/5)
            teta = (kn+kf)/2 * self.sector_size
        else: # narrow candidate valley
            teta = (nearest_valley[0] + nearest_valley[-1]) / 2 * self.sector_size

        return math.radians(teta % 360)
    
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
