# AtlasEdge Builder  
#  
# Version 1.0  
  
FROM ubuntu:12.04  
MAINTAINER Calvin Sangbin Park <calvinspark@gmail.com>  
  
# Use bash. I like bash.  
RUN rm /bin/sh && ln -s /bin/bash /bin/sh  
  
# Install the dependencies.  
RUN apt-get update && \  
apt-get install -y \  
bison build-essential \  
chrpath \  
dh-autoreconf diffstat \  
flex \  
gawk gcc-multilib gperf git-core \  
libqtgui4:i386 libsdl1.2-dev libtool \  
texinfo \  
unzip \  
vim-common \  
wget && \  
apt-get clean  

