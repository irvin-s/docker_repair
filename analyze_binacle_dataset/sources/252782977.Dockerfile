FROM osrf/ros:indigo-desktop-full  
RUN apt-get update && apt-get install -y \  
python-setuptools \  
python-rosinstall \  
ipython \  
libeigen3-dev \  
libboost-all-dev \  
doxygen \  
libopencv-dev \  
ros-indigo-vision-opencv \  
ros-indigo-image-transport-plugins \  
ros-indigo-cmake-modules \  
python-software-properties \  
software-properties-common \  
libpoco-dev \  
python-matplotlib \  
python-scipy \  
python-git \  
python-pip \  
libtbb-dev \  
libblas-dev \  
liblapack-dev \  
python-catkin-tools \  
libv4l-dev \  
wget  
  
RUN pip install python-igraph --upgrade  
ENV KALIBR_WORKSPACE /kalibr_workspace  
  
RUN mkdir -p $KALIBR_WORKSPACE/src &&\  
cd $KALIBR_WORKSPACE &&\  
catkin init &&\  
catkin config --extend /opt/ros/indigo &&\  
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release  
  
RUN cd $KALIBR_WORKSPACE/src &&\  
git clone https://github.com/ethz-asl/Kalibr.git  
  
RUN cd $KALIBR_WORKSPACE &&\  
catkin build -DCMAKE_BUILD_TYPE=Release -j4  
  
COPY ros_entrypoint.sh /ros_entrypoint.sh  

