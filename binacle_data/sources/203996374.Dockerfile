FROM osrf/ubuntu_armhf:xenial

LABEL maintainer="Jack Liu <jacknlliu@gmail.com>"

# setup environment
ENV DEBIAN_FRONTEND noninteractive

ENV LANG en_US.UTF-8

# define ros distribution version
ENV ROS_DISTRO kinetic

COPY scripts/qemu-arm-static  /usr/bin/qemu-arm-static

RUN apt-get update -y -q && apt-get upgrade -y -q && apt-get install -y -q --no-install-recommends apt-utils apt-transport-https locales && locale-gen en_US.UTF-8

# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list  \
    \
# setup keys
    && apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116  \
    \
# update the repository and install ros kinetic
    && apt-get update -y -q && apt-get install -y -q --no-install-recommends ros-kinetic-ros-base python-rosinstall ninja-build


# install additional system packages and ros packages
# install additional build tool
RUN apt-get install -y -q --no-install-recommends build-essential gdb cmake tmux

# install essential tools, ssh sever, sudo
RUN apt-get install -y -q --no-install-recommends bash-completion wget vim git iputils-ping iproute2 netcat \
    openssh-server sudo supervisor v4l-utils libv4l-dev

# install ros related components
# install force dimension device driver and related components
RUN apt-get install -y -q --no-install-recommends libusb-1.0-0 freeglut3 freeglut3-dev \
    \
# install video opencv driver and find_object application
    && apt-get install -y -q --no-install-recommends ros-kinetic-video-stream-opencv ros-kinetic-find-object-2d libcgal-dev

# aptitude clean
RUN apt-get clean -y -q \
    && apt-get autoremove -y -q \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/* /var/tmp/*

# copy supervisord.conf file
COPY ./config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# copy entrypoint file
COPY ./scripts/ros_entrypoint.sh /
RUN chmod +x /ros_entrypoint.sh

RUN mkdir -p /var/run/sshd && echo "X11UseLocalhost no" >> /etc/ssh/sshd_config


# set user ros and sudo
RUN adduser --gecos "ROS User" --home /home/ros --disabled-password ros && \
    usermod -a -G dialout ros && \
    echo "ros ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99_aptget

# switch to user ros, but the HOME is still /, not /home/ros
USER ros

# setup ros env
RUN sudo rosdep init && rosdep update  \
    && echo "source "/opt/ros/$ROS_DISTRO/setup.bash"" >> /home/ros/.bashrc

# cd /home/ros default
WORKDIR /home/ros

CMD ["bash"]
ENTRYPOINT ["/ros_entrypoint.sh"]
