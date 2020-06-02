# Ubuntu  
#  
# VERSION 0.3  
FROM ubuntu:latest  
MAINTAINER Allisson Azevedo <allisson@gmail.com>  
  
# avoid debconf and initrd  
ENV DEBIAN_FRONTEND noninteractive  
ENV INITRD No  
  
# apt config  
ADD source.list /etc/apt/sources.list  
ADD 25norecommends /etc/apt/apt.conf.d/25norecommends  
  
# upgrade distro  
RUN locale-gen en_US en_US.UTF-8  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install lsb-release -y  
  
# clean packages  
RUN apt-get clean  
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  

