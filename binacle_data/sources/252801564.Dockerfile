# Debian: essential  
#  
# VERSION 0.1  
# Pull the base image.  
FROM debian:jessie  
  
MAINTAINER Easywelfare <dev@easywelfare.com>  
  
RUN apt-get update  
RUN apt-get install -y \  
vim \  
curl \  
git \  
wget \  
dnsutils \  
htop  
  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENTRYPOINT ["/bin/bash"]  
  
CMD []  

