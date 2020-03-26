FROM ubuntu:14.04

RUN sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
    sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116 && \
    sudo apt-get update && \
    sudo apt-get install -y ros-jade-ros-base && \
    sudo rosdep init && \
    rosdep update && \
    bash -c 'echo "source /opt/ros/jade/setup.bash" >> ~/.bashrc' && \
    bash -c 'source ~/.bashrc' && \
    sudo apt-get install -y python-rosinstall

RUN sudo apt-get install -y ros-jade-image-view && \
    sudo apt-get install -y ros-jade-compressed-image-transport

COPY extract_data.py /
