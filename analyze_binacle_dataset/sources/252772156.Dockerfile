FROM ros:kinetic  
  
MAINTAINER Iason Sarantopoulos <iasons@auth.gr>  
  
RUN apt-get update && apt-get install -y build-essential sudo wget  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Create catkin workspace  
ENV CATKIN_WS=/root/catkin_ws  
RUN source /opt/ros/kinetic/setup.bash && \  
mkdir -p $CATKIN_WS/src && cd $CATKIN_WS/src && catkin_init_workspace && \  
cd $CATKIN_WS && catkin_make && source $CATKIN_WS/devel/setup.bash  
  
# Build the code, run tests and run linter  
ENTRYPOINT source /opt/ros/kinetic/setup.bash && \  
cd $CATKIN_WS/src/autharl_core && \  
apt-get install -y linux-headers-$(uname -r) && \  
./install.sh -a && \  
source $CATKIN_WS/devel/setup.bash && cd $CATKIN_WS && \  
catkin_make && \  
catkin_make run_tests && catkin_test_results && \  
catkin_make roslint  

