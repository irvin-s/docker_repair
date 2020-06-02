FROM ros:kinetic-ros-base-xenial  
  
RUN apt update && \  
apt upgrade -y  
  
RUN apt install -y \  
ros-kinetic-ros-tutorials \  
ros-kinetic-common-tutorials  
  
RUN rm -rf /var/lib/apt/lists/  

