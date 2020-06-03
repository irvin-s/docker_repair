FROM ubuntu:14.04  
MAINTAINER BoardIQ <tech@boardintelligence.co.uk>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN echo "2014/05/11" > /etc/apt/.last_docker_update  
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade  
RUN apt-get -y install curl software-properties-common  

