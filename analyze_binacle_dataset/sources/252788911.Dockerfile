#  
# Dronecourse PX4 gazebo/gzweb development environment  
#  
  
FROM px4io/px4-dev-simulation  
MAINTAINER Julien Lecoeur <julien.lecoeur@gmail.com>  
  
# install packages  
RUN apt-get update && apt-get upgrade -q -y && apt-get install -q -y \  
build-essential \  
cmake \  
imagemagick \  
libboost-all-dev \  
libgts-dev \  
libjansson-dev \  
libtinyxml-dev \  
mercurial \  
nodejs \  
nodejs-legacy \  
npm \  
pkg-config \  
psmisc\  
xvfb \  
&& rm -rf /var/lib/apt/lists/*  
# install gazebo packages  
RUN apt-get install -q -y \  
libgazebo7-dev \  
&& rm -rf /var/lib/apt/lists/*  
# clone gzweb  
RUN hg clone https://bitbucket.org/osrf/gzweb /usr/share/gzweb  
# build gzweb  
RUN /bin/bash -c "cd /usr/share/gzweb \  
&& hg up gzweb_2.0.0 \  
&& mkdir -p /usr/share/gzweb/http/client/assets/ \  
&& source /usr/share/gazebo/setup.sh \  
&& xvfb-run -s '-screen 0 1280x1024x24' ./deploy.sh -m"  
# setup environment  
EXPOSE 8080  
EXPOSE 7681  

