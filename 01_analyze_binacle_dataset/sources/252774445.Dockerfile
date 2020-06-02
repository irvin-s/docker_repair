FROM ubuntu:14.04  
MAINTAINER Daichi TOMA <amothic@gmail.com>  
  
RUN apt-get update  
RUN apt-get upgrade -y  
  
# Install mumble-server  
RUN apt-get install -y mumble-server  
  
EXPOSE 64738 64738/udp  
  
ENTRYPOINT ["/usr/sbin/murmurd", "-fg", "-ini", "/etc/mumble-server.ini"]  

