FROM kaixhin/caffe

# setup environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# setup keys
RUN apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116
# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list

# install bootstrap tools
ENV ROS_DISTRO indigo
RUN apt-get update && apt-get install --no-install-recommends -y \
      python-rosdep \
      python-rosinstall \
      python-vcstools && \
    rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
    rosdep update

# install ros packages
RUN apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-ros-core \
      ros-${ROS_DISTRO}-usb-cam \
      ros-${ROS_DISTRO}-rosbridge-server \
      ros-${ROS_DISTRO}-roswww \
      ros-${ROS_DISTRO}-mjpeg-server \
      ros-${ROS_DISTRO}-dynamic-reconfigure \
      python-twisted \
      python-catkin-tools && \
    rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]

# setup catkin workspace
ENV CATKIN_WS=/root/catkin_ws
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS/src

# clone ros-caffe project
RUN git clone https://github.com/ruffsl/ros_caffe.git

# HACK, replacing shell with bash for later source, catkin build commands
RUN mv /bin/sh /bin/sh-old && \
    ln -s /bin/bash /bin/sh

# build ros-caffe ros wrapper
WORKDIR $CATKIN_WS
ENV TERM xterm
ENV PYTHONIOENCODING UTF-8
RUN source "/opt/ros/$ROS_DISTRO/setup.bash" && \
    catkin build --no-status && \
    ldconfig

# Get helpful dev dependencies
# RUN apt-get update && apt-get install -q -y \
#     	curl \
#     	wget \
#     	screen \
#     	byobu \
#     	fish \
#     	git \
#     	nano \
#     	glances \
#       bash-completion \
#       less \
#       tree

# Enable bash-completion
# RUN echo 'if [ -f /etc/bash_completion ] && ! shopt -oq posix; then\n\
#     . /etc/bash_completion\n\
# fi\n'\
# >> ~/.bashrc

RUN echo 'source "/opt/ros/${ROS_DISTRO}/setup.bash"\n\
    source "/root/catkin_ws/devel/setup.bash"\n'\
		>> ~/.bashrc
