FROM ubuntu:14.04  
  
MAINTAINER Thomas Rambrant thomas@doorway.se  
  
RUN apt-get update && \  
apt-get install -y curl && \  
apt-get install -y lynx-cur  

