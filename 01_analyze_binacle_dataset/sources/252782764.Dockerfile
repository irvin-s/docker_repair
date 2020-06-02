# davetcoleman/docker:kinetic-source  
# Downloads Debians that Dave releases and tests them before blooming  
FROM osrf/ros:kinetic-desktop  
MAINTAINER Dave Coleman dave@dav.ee  
  
ENV CATKIN_WS=/root/ws_catkin  
RUN mkdir -p $CATKIN_WS/src  
WORKDIR $CATKIN_WS/src  
  
# download moveit source  
RUN git clone https://github.com/davetcoleman/rviz_visual_tools.git && \  
git clone https://github.com/davetcoleman/graph_msgs.git && \  
git clone https://github.com/davetcoleman/rosparam_shortcuts.git && \  
git clone https://github.com/davetcoleman/ros_control_boilerplate.git && \  
git clone https://github.com/davetcoleman/cartesian_msgs.git  
#git clone https://github.com/davetcoleman/tf_keyboard_cal.git && \  
#git clone https://github.com/davetcoleman/moveit_visual_tools.git && \  
#git clone https://github.com/davetcoleman/moveit_sim_controller.git  
#git clone https://github.com/davetcoleman/ompl_visual_tools.git && \  
# update apt-get because osrf image clears this cache and download deps  
RUN apt-get update && \  
rosdep update && \  
apt-get install -y \  
python-catkin-tools \  
less \  
sudo && \  
rosdep install -y --from-paths . --ignore-src --rosdistro ${ROS_DISTRO} && \  
rm -rf /var/lib/apt/lists/*  
  
# HACK, replacing shell with bash for later docker build commands  
RUN mv /bin/sh /bin/sh-old && \  
ln -s /bin/bash /bin/sh  
  
# build repo  
WORKDIR $CATKIN_WS  
RUN source /ros_entrypoint.sh && \  
catkin build --no-status  

