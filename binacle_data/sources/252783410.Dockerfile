#!/usr/bin/docker build  
# Dockerfile for gated  
# Based on Debian 9  
FROM debian:9  
# Add the files to the image  
ADD ./scripts /opt/gated/scripts  
ADD ./etc /opt/gated/etc  
  
# Set up the system  
RUN /opt/gated/scripts/init.sh  
  
# Configure the system for gated  
RUN /opt/gated/scripts/configure.sh  
  
# Start gated  
CMD [ "/opt/gated/scripts/start.sh" ]  

