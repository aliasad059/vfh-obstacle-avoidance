#!/usr/bin/python3

# ROS
import rospy
from geometry_msgs.msg import Twist
from nav_msgs.msg import Odometry
import tf
from turtlebot3_obstacle_avoidance.srv import ObstacleAvoidanceService, ObstacleAvoidanceServiceRequest

class Controller:
    def __init__(self) -> None:
        # Use these Twists to control your robot
        self.move = Twist()
        self.move.linear.x = 0.1

        self.current_yaw = 0
        self.current_x = 0
        self.current_y = 0

        # The "p" parameter for your p-controller
        self.angular_vel_coef = 1

        # Create a service proxy for obstacle avoidance service
        rospy.wait_for_service('vfh_obstacle_avoidance')
        self.obstacle_avoidance_proxy = rospy.ServiceProxy('vfh_obstacle_avoidance', ObstacleAvoidanceService)

        # Create a publisher for robot "cmd_vel"
        self.cmd_vel_publisher = rospy.Publisher('/cmd_vel', Twist, queue_size=1)

        # Subscribe to Odometry to get current angle of robot
        self.odom_sub = rospy.Subscriber('/odom', Odometry, self.odom_callback)

   
    def odom_callback(self, msg):
        self.current_x = int(msg.pose.pose.position.x)
        self.current_y = int(msg.pose.pose.position.y)
        orientation = msg.pose.pose.orientation
        _, _, self.current_yaw = tf.transformations.euler_from_quaternion((orientation.x, orientation.y, orientation.z, orientation.w))
        pass

    def run(self) -> None:
        try:
            while not rospy.is_shutdown():
                streering_direction = self.call_obstacle_avoidance()
                self.adjust_robot_movement(streering_direction)

                rospy.sleep(0.1)

        except rospy.exceptions.ROSInterruptException:
            pass

    def call_obstacle_avoidance(self):
        try:
            request = ObstacleAvoidanceServiceRequest()
            request.current_x = self.current_x
            request.current_y = self.current_y
            response = self.obstacle_avoidance_proxy(request)

            return response.streering_direction
        
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s" % str(e))

    def adjust_robot_movement(self, streering_direction):
        error = self.calculate_error(streering_direction)
        self.move.angular.z = self.angular_vel_coef * error

        self.cmd_vel_publisher.publish(self.move)

    def calculate_error(self, streering_direction):
        rospy.loginfo(f'goal angle: {streering_direction}, current angle: {self.current_yaw}')
        return streering_direction - self.current_yaw


if __name__ == "__main__":
    rospy.init_node("controller", anonymous=True)
    
    controller = Controller()
    controller.run()
    

