FROM jacknlliu/ros:kinetic-core

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"

# install ros related components
RUN aptitude update -y && aptitude install -y -q -R ros-kinetic-gazebo-ros-control \
    ros-kinetic-ros-controllers \
    ros-kinetic-rqt-controller-manager \
    ros-kinetic-moveit \
    ros-kinetic-orocos-kdl \
    ros-kinetic-orocos-kinematics-dynamics \
    ros-kinetic-pid  \
    \
# install Barret_Hand related components
    && aptitude install -y -q -R libignition-math2-dev ros-kinetic-barrett-hand ros-kinetic-barrett-hand-sim \
    \
# install force dimension device driver and related components
    && aptitude install -y -q -R libusb-1.0-0 freeglut3 freeglut3-dev \
    \
# install kinematics module
    && aptitude install -y -q -R ros-kinetic-calibration-estimation ros-kinetic-kdl-parser-py  \
    \
# install fast inverse kinematics module
    && aptitude install -y -q -R ros-kinetic-katana-moveit-ikfast-plugin  ros-kinetic-trac-ik-lib ros-kinetic-trac-ik-kinematics-plugin \
    \
# install video opencv driver and find_object application
    && aptitude install -y -q -R ros-kinetic-video-stream-opencv ros-kinetic-find-object-2d libcgal-dev  libcgal-qt5-dev

# aptitude clean
RUN apt-get autoclean \
    && apt-get clean all \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*
