FROM ubuntu:xenial

ENV GIT_USER_NAME mrbuild
ENV GIT_USER_EMAIL mrbuild@github.com
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y git wget curl locales python
RUN locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

RUN /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list' \
&& apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116

RUN apt install -y gnupg2 lsb-release
RUN curl http://repo.ros2.org/repos.key | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

# Install prerequisites
RUN export DEBIAN_FRONTEND=noninteractive && apt update && apt install -y \
  build-essential \
  cmake \
  python3-colcon-common-extensions \
  python3-pip \
  python-rosdep \
  python3-vcstool \
  libpython3-dev \
  libtinyxml2.6.2v5 \
  libtinyxml2-dev \
  cppcheck

RUN rosdep init
RUN rosdep update

# Configure git
RUN git config --global user.name $GIT_USER_NAME \
    && git config --global user.email $GIT_USER_EMAIL

# Get ROS2 latest package
ENV ROS2_WS=/root
WORKDIR $ROS2_WS

RUN wget https://github.com/ros2/ros2/releases/download/release-crystal-20190408/ros2-crystal-20190408-linux-xenial-amd64.tar.bz2 \
    && tar xf ros2-crystal-20190408-linux-xenial-amd64.tar.bz2

RUN echo "source $ROS2_WS/ros2-linux/local_setup.bash" >> $HOME/.bashrc

# Install nvm, Node.js and node-gyp
ENV NODE_VERSION v10.15.3
RUN wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
    && . $HOME/.nvm/nvm.sh \
    && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION

ENV PATH /bin/versions/node/$NODE_VERSION/bin:$PATH
