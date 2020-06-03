FROM ubuntu:14.04  
MAINTAINER abobier <abobier@gmail.com>  
  
RUN apt-get update && apt-get install -y mesa-utils  
RUN apt-get install -y xserver-xorg-video-all  
  

