#!/usr/bin/python3
from copy import deepcopy
import rospy
from sensor_msgs.msg import LaserScan
from scipy.signal import argrelmin
import numpy as np
from turtlebot3_obstacle_avoidance.srv import ObstacleAvoidanceService, ObstacleAvoidanceServiceResponse
import math
import matplotlib.pyplot as plt

class VFH():
    def __init__(self, vfh_config) -> None:

        rospy.init_node('vfh_obstacle_avoidance', anonymous=True)

        self.destination = vfh_config['destination']
        self.a = vfh_config['a']
        self.b = vfh_config['b']
        self.smoothing_factor = vfh_config['smoothing_factor']
        self.sector_size = vfh_config['sector_size']
        self.threshold = vfh_config['threshold']

        self.histogram_field_vector = None

        self.obstacle_avoidance_service = rospy.Service('vfh_obstacle_avoidance', ObstacleAvoidanceService, self.obstacle_avoidance_callback)
        self.scan_sub = rospy.Subscriber('/scan', LaserScan, self.scan_callback)
    
    def obstacle_avoidance_callback(self, req):
        
        self.current_x = req.current_x
        self.current_y = req.current_y
        self.current_yaw = req.current_yaw
        self.destination = [req.current_goal_x, req.current_goal_y]

        response = ObstacleAvoidanceServiceResponse()
        response.streering_direction = self.find_steering_direction()
        # print(response)
        return response

    def scan_callback(self, msg):
        ranges = np.array(msg.ranges)
        # ranges = [max(min(r, msg.range_max), msg.range_min) for r in ranges]
        # print(len(ranges))
        angles = np.arange(msg.angle_min, msg.angle_max + msg.angle_increment, msg.angle_increment)
        # print(len(angles))
        histogram_field_vector = self.calculate_histogram_field_vector(ranges, angles)
        self.histogram_field_vector = self.smooth_histogram(histogram_field_vector)
    
    def calculate_histogram_field_vector(self, ranges, angles):
        num_sectors = int(360 / self.sector_size)
        sector_histogram = np.zeros(num_sectors)
        
        for i, distance in enumerate(ranges):
            if np.isnan(distance) or np.isinf(distance):
                continue

            sector_index = int(((np.degrees(angles[i])) / self.sector_size)) % num_sectors
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
        goal_angle = np.arctan2(self.destination[1] - current_position[1], self.destination[0] - current_position[0])

        if goal_angle < 0:
            goal_angle += 2 * math.pi

        dif = goal_angle - self.current_yaw
        if dif < 0:
            dif += 2 * math.pi
        
        
        goal_angle_deg = np.degrees(dif) % 360
        
        goal_sector = int(goal_angle_deg / self.sector_size)
        
        return goal_sector
    
    def get_candidate_valleys(self):
        threshold = self.threshold
        while True:
            valleys_idx = []
            for i in range(len(self.histogram_field_vector)):
                if self.histogram_field_vector[i] < threshold:
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
            
            filtered_valley = []
            values_to_remove = list(range(13, 58))
            for v in valleys:
                v = [h for h in v if h not in values_to_remove]
                if v:
                    filtered_valley.append(v)
            
            if len(filtered_valley) == 0:
                threshold += 0.5
                # rospy.loginfo(f'threshold set to {threshold}')
                continue
            else:
                threshold = self.threshold
                return filtered_valley

    def find_steering_direction(self):
        if self.histogram_field_vector is None:
            return 0
        # self.plot_polar_density_histogram()
        # rospy.loginfo(f'vector-fields: {self.histogram_field_vector}')
        valleys = self.get_candidate_valleys()
        rospy.loginfo(f'valleys: {valleys}')

        goal_sector = self.get_goal_sector()
        
        min_distance = np.inf
        nearest_valley = None
        kn = None
        for candidate_valley in valleys:
            if goal_sector in candidate_valley:
                teta = goal_sector
                teta = teta  * self.sector_size
                teta = teta % 360
                rospy.loginfo(f'candidate valley:{candidate_valley}, GOAL-SECTOR: {goal_sector}, teta: {teta}')
                return math.radians(teta) # goal sector is in a candidate valley
            
            
            distances = np.abs(np.array(candidate_valley) + 72 - goal_sector)
            min_idx = np.argmin(distances)
            if distances[min_idx] < min_distance:
                min_distance = distances[min_idx]
                nearest_valley = candidate_valley
                # kn = min_idx

            distances = np.abs(np.array(candidate_valley) - goal_sector)
            min_idx = np.argmin(distances)
            if distances[min_idx] < min_distance:
                min_distance = distances[min_idx]
                nearest_valley = candidate_valley
                # kn = min_idx
        
        teta = nearest_valley[(len(nearest_valley) // 2)]
        teta = teta  * self.sector_size
        teta = teta % 360
        rospy.loginfo(f'candidate valley:{nearest_valley}, goal-sector: {goal_sector}, teta: {teta}')
        
        # rospy.loginfo(f'theta: {teta}, goal sector NOT in candidate valley. choosing the best sector...')
        # rospy.loginfo(f'candidate valley:{nearest_valley}, kn: {kn}, goal-sector: {goal_sector}, kf: {kf}')
        return math.radians(teta)
        
    
    def plot_polar_density_histogram(self):

        import numpy as np
        import matplotlib.pyplot as plt

        angles = np.arange(0, 360, 5)
        density_values = self.histogram_field_vector

        # Plotting setup
        fig = plt.figure()
        ax = fig.add_subplot(111, projection='polar')

        # Convert angles to radians
        theta = np.radians(angles)

        # Plot the polar bar chart
        bars = ax.bar(theta, density_values, width=np.radians(5), align='edge')

        # Customize the appearance of the bars
        for bar in bars:
            bar.set_alpha(0.7)
            bar.set_facecolor('blue')

        ax.set_title("Polar Bar Chart")
        ax.set_ylim([0, np.max(density_values)])

        plt.savefig("test_rasterization.pdf", dpi=150)



    
    def run(self):
        rospy.spin()

if __name__ == "__main__":
    try:
        config = {
            'destination' : [13, 7],
            'a' : 1,
            'b' : 0.25, 
            'smoothing_factor': 2,
            'sector_size': 5,
            'threshold':6
        }
        vfh_node = VFH(vfh_config=config)
        vfh_node.run()
    except rospy.ROSInterruptException:
        pass
