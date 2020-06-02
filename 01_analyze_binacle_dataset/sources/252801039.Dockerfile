FROM ros:kinetic-robot  
  
RUN apt-get update  
RUN apt-get install -y python-bloom  
RUN apt-get install -y openssh-client zip  
RUN apt-get install -y python-pip python-dev build-essential python-tk  
RUN pip install Cython  
RUN apt-get install -y python-catkin-tools  
RUN apt-get install -y ros-kinetic-desktop-full  

