#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_control"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/hosna/Desktop/project/senario2/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/hosna/Desktop/project/senario2/install/lib/python3/dist-packages:/home/hosna/Desktop/project/senario2/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/hosna/Desktop/project/senario2/build" \
    "/usr/bin/python3" \
    "/home/hosna/Desktop/project/senario2/src/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_control/setup.py" \
     \
    build --build-base "/home/hosna/Desktop/project/senario2/build/turtlebot3_autorace_2020/turtlebot3_autorace_intersection/turtlebot3_autorace_intersection_control" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/hosna/Desktop/project/senario2/install" --install-scripts="/home/hosna/Desktop/project/senario2/install/bin"
