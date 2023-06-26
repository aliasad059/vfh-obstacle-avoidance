// Auto-generated. Do not edit!

// (in-package turtlebot3_autorace_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class MovingParam {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.moving_type = null;
      this.moving_value_angular = null;
      this.moving_value_linear = null;
    }
    else {
      if (initObj.hasOwnProperty('moving_type')) {
        this.moving_type = initObj.moving_type
      }
      else {
        this.moving_type = 0;
      }
      if (initObj.hasOwnProperty('moving_value_angular')) {
        this.moving_value_angular = initObj.moving_value_angular
      }
      else {
        this.moving_value_angular = 0.0;
      }
      if (initObj.hasOwnProperty('moving_value_linear')) {
        this.moving_value_linear = initObj.moving_value_linear
      }
      else {
        this.moving_value_linear = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type MovingParam
    // Serialize message field [moving_type]
    bufferOffset = _serializer.uint8(obj.moving_type, buffer, bufferOffset);
    // Serialize message field [moving_value_angular]
    bufferOffset = _serializer.float32(obj.moving_value_angular, buffer, bufferOffset);
    // Serialize message field [moving_value_linear]
    bufferOffset = _serializer.float32(obj.moving_value_linear, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type MovingParam
    let len;
    let data = new MovingParam(null);
    // Deserialize message field [moving_type]
    data.moving_type = _deserializer.uint8(buffer, bufferOffset);
    // Deserialize message field [moving_value_angular]
    data.moving_value_angular = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [moving_value_linear]
    data.moving_value_linear = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a message object
    return 'turtlebot3_autorace_msgs/MovingParam';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '603d953881321b4196ac96fba411105f';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ########################################
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new MovingParam(null);
    if (msg.moving_type !== undefined) {
      resolved.moving_type = msg.moving_type;
    }
    else {
      resolved.moving_type = 0
    }

    if (msg.moving_value_angular !== undefined) {
      resolved.moving_value_angular = msg.moving_value_angular;
    }
    else {
      resolved.moving_value_angular = 0.0
    }

    if (msg.moving_value_linear !== undefined) {
      resolved.moving_value_linear = msg.moving_value_linear;
    }
    else {
      resolved.moving_value_linear = 0.0
    }

    return resolved;
    }
};

// Constants for message
MovingParam.Constants = {
  MOVING_TYPE_IDLE: 0,
  MOVING_TYPE_LEFT: 1,
  MOVING_TYPE_RIGHT: 2,
  MOVING_TYPE_FORWARD: 3,
  MOVING_TYPE_BACKWARD: 4,
}

module.exports = MovingParam;
