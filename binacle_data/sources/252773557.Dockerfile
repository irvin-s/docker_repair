FROM ubuntu:14.04  
  
RUN apt-get update && apt-get install -y \  
git \  
vim \  
default-jre \  
nodejs \  
npm \  
xvfb \  
firefox  
  
RUN ln -s `which nodejs` /usr/bin/node  
  

