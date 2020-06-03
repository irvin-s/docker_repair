# Ubuntu 16.04 container with en_AU locale support and upgraded udev.  
FROM phusion/baseimage:0.9.19  
MAINTAINER Chinthaka Godawita <chin.godawita@me.com>  
  
# Set locale to be en_AU.  
RUN locale-gen en_AU en_AU.UTF-8  
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales  
RUN update-locale LC_ALL=en_AU.UTF-8 LANG=en_AU.UTF-8 LANGUAGE=en_AU:en  
  
# Setup environment variables.  
ENV LANG en_AU.UTF-8  
ENV LANGUAGE en_AU:en  
ENV LC_ALL en_AU.UTF-8  
  
# Upgrade udev here as it's not supported on CircleCI.  
RUN DEBIAN_FRONTEND=noninteractive apt-get update  
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y udev  
  
# During startup, before running any startup scripts, my_init imports  
# environment variables from the directory /etc/container_environment .  
# This directory contains files who are named after the environment  
# variable names. The following environment variables are setup again  
# as an example for inheriting images.  
RUN echo "en_AU.UTF-8" > /etc/container_environment/LANG  
RUN echo "en_AU:en" > /etc/container_environment/LANGUAGE  
RUN echo "en_AU.UTF-8" > /etc/container_environment/LC_ALL  

