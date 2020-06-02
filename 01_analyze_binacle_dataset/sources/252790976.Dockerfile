FROM ubuntu:16.04  
  
RUN apt update -y &&\  
apt upgrade -y &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

