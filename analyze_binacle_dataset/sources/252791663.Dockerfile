FROM gazebo:gzserver6  
MAINTAINER Daniel Langerenken daniel.langerenken@gmail.com  
  
# install packages  
RUN apt-get update && apt-get install -q -y \  
binutils \  
mesa-utils \  
module-init-tools \  
x-window-system\  
&& rm -rf /var/lib/apt/lists/*  
# install gazebo packages  
RUN apt-get update && apt-get install -q -y \  
gazebo6=6.1.0* \  
&& rm -rf /var/lib/apt/lists/*  

