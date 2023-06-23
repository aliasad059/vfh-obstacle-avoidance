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
        orientation = msg.pose.pose.orientation
        _, _, self.current_yaw = tf.transformations.euler_from_quaternion((orientation.x, orientation.y, orientation.z, orientation.w))
        pass

    def run(self) -> None:
        try:
            while not rospy.is_shutdown():
                goal_angle = self.call_obstacle_avoidance()
                self.adjust_robot_movement(goal_angle)

                rospy.sleep(0.1)

        except rospy.exceptions.ROSInterruptException:
            pass

    def call_obstacle_avoidance(self):
        try:
            request = ObstacleAvoidanceServiceRequest()
            response = self.obstacle_avoidance_proxy(request)

            return response.goal_angle
        
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s" % str(e))

    def adjust_robot_movement(self, goal_angle):
        error = self.calculate_error(goal_angle)
        self.move.angular.z = self.angular_vel_coef * error

        self.cmd_vel_publisher.publish(self.move)

    def calculate_error(self, goal_angle):
        rospy.loginfo(f'goal angle: {goal_angle}, current angle: {self.current_yaw}')
        return goal_angle - self.current_yaw


if __name__ == "__main__":
    rospy.init_node("controller", anonymous=True)
    
    controller = Controller()
    controller.run()
    

