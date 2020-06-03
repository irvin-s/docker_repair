FROM ros:dashing

LABEL maintainer="Lander Usategui lander@erlerobotics.com"

ENV TERM xterm
ENV ROS_DISTRO dashing
ENV ROS_WS=/opt/ws_moveit
WORKDIR $ROS_WS

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN \
       apt-get update -qq && apt-get install -qq -y \
         wget \
         clang clang-format-3.9 clang-tidy clang-tools \
      && rm -rf /var/lib/apt/lists/*

# Download moveit source, so that we can get necessary dependencies
RUN mkdir -p $ROS_WS/src \
    && wget https://raw.githubusercontent.com/AcutronicRobotics/moveit2/master/moveit2.repos \
    && vcs import src < moveit2.repos \
    && cd src && git clone https://github.com/AcutronicRobotics/moveit2
    # wstool init --shallow . https://raw.githubusercontent.com/ros-planning/moveit2/master/moveit.rosinstall

# Download all MoveIt 2 dependencies
RUN \
    apt-get -qq update && \
    rosdep update -q && \
    rosdep install -q -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} --as-root=apt:false || true && \
    # Clear apt-cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# Remove the source code from this container
# TODO: in the future we may want to keep this here for further optimization of later containers
RUN cd $ROS_WS && \
    rm -rf src/


# Continous Integration Setting
ENV IN_DOCKER 1
ENV DOCKER 1 # old version, keep for now

CMD ["bash"]
