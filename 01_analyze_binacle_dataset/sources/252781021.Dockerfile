FROM ubuntu:latest  
MAINTAINER Mihai <costache.mircea.mihai@gmail.com>  
  
RUN \  
apt-get update && \  
apt-get -y install libgl1-mesa-glx libgl1-mesa-dri 0ad pavucontrol && \  
rm -rf /var/lib/apt/lists/*  
RUN useradd -m player  
USER player  
ENTRYPOINT ["/usr/games/0ad"]  
  

