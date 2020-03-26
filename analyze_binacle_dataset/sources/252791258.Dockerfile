FROM cyrillg/vnc-ros-gnome  
MAINTAINER Cyrill Guillemot "https://github.com/cyrillg"  
WORKDIR $HOME  
  
RUN apt-get install -y ros-kinetic-gazebo-ros-pkgs  
COPY files/.gazebo .gazebo  
RUN touch new_file.txt  
  
CMD ["/usr/bin/supervisord"]  
  

