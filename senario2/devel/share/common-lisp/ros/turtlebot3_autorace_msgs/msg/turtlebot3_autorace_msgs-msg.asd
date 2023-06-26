
(cl:in-package :asdf)

(defsystem "turtlebot3_autorace_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "MovingParam" :depends-on ("_package_MovingParam"))
    (:file "_package_MovingParam" :depends-on ("_package"))
  ))