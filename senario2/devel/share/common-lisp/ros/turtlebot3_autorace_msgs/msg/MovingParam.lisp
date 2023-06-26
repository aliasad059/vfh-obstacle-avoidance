; Auto-generated. Do not edit!


(cl:in-package turtlebot3_autorace_msgs-msg)


;//! \htmlinclude MovingParam.msg.html

(cl:defclass <MovingParam> (roslisp-msg-protocol:ros-message)
  ((moving_type
    :reader moving_type
    :initarg :moving_type
    :type cl:fixnum
    :initform 0)
   (moving_value_angular
    :reader moving_value_angular
    :initarg :moving_value_angular
    :type cl:float
    :initform 0.0)
   (moving_value_linear
    :reader moving_value_linear
    :initarg :moving_value_linear
    :type cl:float
    :initform 0.0))
)

(cl:defclass MovingParam (<MovingParam>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MovingParam>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MovingParam)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name turtlebot3_autorace_msgs-msg:<MovingParam> is deprecated: use turtlebot3_autorace_msgs-msg:MovingParam instead.")))

(cl:ensure-generic-function 'moving_type-val :lambda-list '(m))
(cl:defmethod moving_type-val ((m <MovingParam>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot3_autorace_msgs-msg:moving_type-val is deprecated.  Use turtlebot3_autorace_msgs-msg:moving_type instead.")
  (moving_type m))

(cl:ensure-generic-function 'moving_value_angular-val :lambda-list '(m))
(cl:defmethod moving_value_angular-val ((m <MovingParam>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot3_autorace_msgs-msg:moving_value_angular-val is deprecated.  Use turtlebot3_autorace_msgs-msg:moving_value_angular instead.")
  (moving_value_angular m))

(cl:ensure-generic-function 'moving_value_linear-val :lambda-list '(m))
(cl:defmethod moving_value_linear-val ((m <MovingParam>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader turtlebot3_autorace_msgs-msg:moving_value_linear-val is deprecated.  Use turtlebot3_autorace_msgs-msg:moving_value_linear instead.")
  (moving_value_linear m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<MovingParam>)))
    "Constants for message type '<MovingParam>"
  '((:MOVING_TYPE_IDLE . 0)
    (:MOVING_TYPE_LEFT . 1)
    (:MOVING_TYPE_RIGHT . 2)
    (:MOVING_TYPE_FORWARD . 3)
    (:MOVING_TYPE_BACKWARD . 4))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'MovingParam)))
    "Constants for message type 'MovingParam"
  '((:MOVING_TYPE_IDLE . 0)
    (:MOVING_TYPE_LEFT . 1)
    (:MOVING_TYPE_RIGHT . 2)
    (:MOVING_TYPE_FORWARD . 3)
    (:MOVING_TYPE_BACKWARD . 4))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MovingParam>) ostream)
  "Serializes a message object of type '<MovingParam>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'moving_type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'moving_value_angular))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'moving_value_linear))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MovingParam>) istream)
  "Deserializes a message object of type '<MovingParam>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'moving_type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'moving_value_angular) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'moving_value_linear) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MovingParam>)))
  "Returns string type for a message object of type '<MovingParam>"
  "turtlebot3_autorace_msgs/MovingParam")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MovingParam)))
  "Returns string type for a message object of type 'MovingParam"
  "turtlebot3_autorace_msgs/MovingParam")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MovingParam>)))
  "Returns md5sum for a message object of type '<MovingParam>"
  "603d953881321b4196ac96fba411105f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MovingParam)))
  "Returns md5sum for a message object of type 'MovingParam"
  "603d953881321b4196ac96fba411105f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MovingParam>)))
  "Returns full string definition for message of type '<MovingParam>"
  (cl:format cl:nil "########################################~%# CONSTANTS~%########################################~%uint8 MOVING_TYPE_IDLE = 0~%uint8 MOVING_TYPE_LEFT = 1~%uint8 MOVING_TYPE_RIGHT = 2~%uint8 MOVING_TYPE_FORWARD = 3~%uint8 MOVING_TYPE_BACKWARD = 4~%~%########################################~%# Messages~%########################################~%uint8 moving_type~%float32 moving_value_angular~%float32 moving_value_linear~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MovingParam)))
  "Returns full string definition for message of type 'MovingParam"
  (cl:format cl:nil "########################################~%# CONSTANTS~%########################################~%uint8 MOVING_TYPE_IDLE = 0~%uint8 MOVING_TYPE_LEFT = 1~%uint8 MOVING_TYPE_RIGHT = 2~%uint8 MOVING_TYPE_FORWARD = 3~%uint8 MOVING_TYPE_BACKWARD = 4~%~%########################################~%# Messages~%########################################~%uint8 moving_type~%float32 moving_value_angular~%float32 moving_value_linear~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MovingParam>))
  (cl:+ 0
     1
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MovingParam>))
  "Converts a ROS message object to a list"
  (cl:list 'MovingParam
    (cl:cons ':moving_type (moving_type msg))
    (cl:cons ':moving_value_angular (moving_value_angular msg))
    (cl:cons ':moving_value_linear (moving_value_linear msg))
))
