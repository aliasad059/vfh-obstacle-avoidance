;; Auto-generated. Do not edit!


(when (boundp 'turtlebot3_autorace_msgs::MovingParam)
  (if (not (find-package "TURTLEBOT3_AUTORACE_MSGS"))
    (make-package "TURTLEBOT3_AUTORACE_MSGS"))
  (shadow 'MovingParam (find-package "TURTLEBOT3_AUTORACE_MSGS")))
(unless (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM")
  (make-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))

(in-package "ROS")
;;//! \htmlinclude MovingParam.msg.html


(intern "*MOVING_TYPE_IDLE*" (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(shadow '*MOVING_TYPE_IDLE* (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(defconstant turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_IDLE* 0)
(intern "*MOVING_TYPE_LEFT*" (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(shadow '*MOVING_TYPE_LEFT* (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(defconstant turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_LEFT* 1)
(intern "*MOVING_TYPE_RIGHT*" (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(shadow '*MOVING_TYPE_RIGHT* (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(defconstant turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_RIGHT* 2)
(intern "*MOVING_TYPE_FORWARD*" (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(shadow '*MOVING_TYPE_FORWARD* (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(defconstant turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_FORWARD* 3)
(intern "*MOVING_TYPE_BACKWARD*" (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(shadow '*MOVING_TYPE_BACKWARD* (find-package "TURTLEBOT3_AUTORACE_MSGS::MOVINGPARAM"))
(defconstant turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_BACKWARD* 4)

(defun turtlebot3_autorace_msgs::MovingParam-to-symbol (const)
  (cond
        ((= const 0) 'turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_IDLE*)
        ((= const 1) 'turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_LEFT*)
        ((= const 2) 'turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_RIGHT*)
        ((= const 3) 'turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_FORWARD*)
        ((= const 4) 'turtlebot3_autorace_msgs::MovingParam::*MOVING_TYPE_BACKWARD*)
        (t nil)))

(defclass turtlebot3_autorace_msgs::MovingParam
  :super ros::object
  :slots (_moving_type _moving_value_angular _moving_value_linear ))

(defmethod turtlebot3_autorace_msgs::MovingParam
  (:init
   (&key
    ((:moving_type __moving_type) 0)
    ((:moving_value_angular __moving_value_angular) 0.0)
    ((:moving_value_linear __moving_value_linear) 0.0)
    )
   (send-super :init)
   (setq _moving_type (round __moving_type))
   (setq _moving_value_angular (float __moving_value_angular))
   (setq _moving_value_linear (float __moving_value_linear))
   self)
  (:moving_type
   (&optional __moving_type)
   (if __moving_type (setq _moving_type __moving_type)) _moving_type)
  (:moving_value_angular
   (&optional __moving_value_angular)
   (if __moving_value_angular (setq _moving_value_angular __moving_value_angular)) _moving_value_angular)
  (:moving_value_linear
   (&optional __moving_value_linear)
   (if __moving_value_linear (setq _moving_value_linear __moving_value_linear)) _moving_value_linear)
  (:serialization-length
   ()
   (+
    ;; uint8 _moving_type
    1
    ;; float32 _moving_value_angular
    4
    ;; float32 _moving_value_linear
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _moving_type
       (write-byte _moving_type s)
     ;; float32 _moving_value_angular
       (sys::poke _moving_value_angular (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _moving_value_linear
       (sys::poke _moving_value_linear (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _moving_type
     (setq _moving_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32 _moving_value_angular
     (setq _moving_value_angular (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _moving_value_linear
     (setq _moving_value_linear (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get turtlebot3_autorace_msgs::MovingParam :md5sum-) "603d953881321b4196ac96fba411105f")
(setf (get turtlebot3_autorace_msgs::MovingParam :datatype-) "turtlebot3_autorace_msgs/MovingParam")
(setf (get turtlebot3_autorace_msgs::MovingParam :definition-)
      "########################################
# CONSTANTS
########################################
uint8 MOVING_TYPE_IDLE = 0
uint8 MOVING_TYPE_LEFT = 1
uint8 MOVING_TYPE_RIGHT = 2
uint8 MOVING_TYPE_FORWARD = 3
uint8 MOVING_TYPE_BACKWARD = 4

########################################
# Messages
########################################
uint8 moving_type
float32 moving_value_angular
float32 moving_value_linear
")



(provide :turtlebot3_autorace_msgs/MovingParam "603d953881321b4196ac96fba411105f")


