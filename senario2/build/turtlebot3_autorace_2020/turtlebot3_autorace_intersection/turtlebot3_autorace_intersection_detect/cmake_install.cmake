# Install script for directory: /home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/hosna/Desktop/project/senario2/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  include("/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/safe_execute_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/turtlebot3_autorace_intersection_detect" TYPE FILE FILES "/home/hosna/Desktop/project/senario2/devel/include/turtlebot3_autorace_intersection_detect/DetectLaneParamsConfig.h")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/hosna/Desktop/project/senario2/devel/lib/python3/dist-packages/turtlebot3_autorace_intersection_detect/cfg")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/turtlebot3_autorace_intersection_detect" TYPE DIRECTORY FILES "/home/hosna/Desktop/project/senario2/devel/lib/python3/dist-packages/turtlebot3_autorace_intersection_detect/cfg")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/installspace/turtlebot3_autorace_intersection_detect.pc")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/turtlebot3_autorace_intersection_detect/cmake" TYPE FILE FILES
    "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/installspace/turtlebot3_autorace_intersection_detectConfig.cmake"
    "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/installspace/turtlebot3_autorace_intersection_detectConfig-version.cmake"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/turtlebot3_autorace_intersection_detect" TYPE FILE FILES "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/package.xml")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/turtlebot3_autorace_intersection_detect" TYPE PROGRAM FILES "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/installspace/detect_lane")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/turtlebot3_autorace_intersection_detect" TYPE PROGRAM FILES "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/catkin_generated/installspace/detect_sign")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/turtlebot3_autorace_intersection_detect" TYPE DIRECTORY FILES
    "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/cfg"
    "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/file"
    "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/launch"
    "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_detect/param"
    )
endif()

