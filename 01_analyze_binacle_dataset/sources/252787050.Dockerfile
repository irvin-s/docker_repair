FROM osrf/ros:kinetic-desktop-full  
  
# Set the locale  
RUN apt-get clean && apt-get update && apt-get install -y locales  
RUN locale-gen en_US.UTF-8  
  
ENV LANG en_US.UTF-8  
RUN apt-get update && apt-get install -y \  
ros-kinetic-moveit \  
ros-kinetic-industrial-robot-simulator \  
ros-kinetic-ur-description \  
ros-kinetic-turtlebot* \  
software-properties-common \  
terminator \  
curl \  
wget \  
iputils-ping \  
gitk \  
vim \  
emacs24 \  
sudo \  
libgl1-mesa-glx \  
libgl1-mesa-dri \  
mesa-utils  
  
RUN add-apt-repository -y ppa:levi-armstrong/qt-libraries-xenial \  
&& add-apt-repository -y ppa:levi-armstrong/ppa \  
&& apt update && apt install -y qt59creator qt57creator-plugin-ros \  
&& rm -rf /var/likb/apt/lists/*  
  
CMD ["terminator"]  
  

