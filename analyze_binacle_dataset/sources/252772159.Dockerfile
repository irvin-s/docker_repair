#FROM osrf/ros:indigo-desktop-full  
FROM ros:indigo  
  
MAINTAINER Ioannis Agriomallos <jagrio@iti.gr>  
  
RUN apt-get update && apt-get install -y build-essential  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Install additional dependencies  
#RUN $CATKIN_WS/src/ramcip_slippage_detection/setup.sh  
RUN apt-get install -y python2.7 python2.7-dev python-pip && \  
apt-get install -y libfreetype6-dev libxft-dev libpng12-dev \  
gfortran libatlas-base-dev liblapack-dev && \  
pip install --user -U setuptools && \  
pip install --user --upgrade --no-deps numpy==1.12.0 scipy==0.18.1 \  
matplotlib==2.0.0 scikit-learn==0.18.1 nitime==0.7 && \  
pip install --user numpy==1.12.0 scipy==0.18.1 \  
matplotlib==2.0.0 scikit-learn==0.18.1 nitime==0.7  
# apt-get install -y python-pygame  
#RUN apt-get install -y pylint  
# Create catkin workspace  
ENV CATKIN_WS=/root/catkin_ws  
RUN source /opt/ros/indigo/setup.bash && \  
mkdir -p $CATKIN_WS/src && cd $CATKIN_WS/src && catkin_init_workspace && \  
cd $CATKIN_WS && catkin_make && source $CATKIN_WS/devel/setup.bash  
  
# Build the code, run tests and run linter  
ENTRYPOINT source /opt/ros/indigo/setup.bash && \  
apt-get update && \  
cd $CATKIN_WS && \  
rosdep install --from-paths src/ --ignore-src --rosdistro indigo -y && \  
catkin_make && \  
catkin_make roslint_ramcip_slippage_detection && \  
#catkin_make run_tests && \  
source $CATKIN_WS/devel/setup.bash && \  
rosrun ramcip_slippage_detection test.py && \  
# && echo "OK" || echo "NOT OK" && \  
# cd src && rosrun roslint pep8 `find .` 2>&1 | grep -v
'Skipping\|Ignoring\|git' && \  
function capture() { return ${PIPESTATUS[0]}; }; capture  

