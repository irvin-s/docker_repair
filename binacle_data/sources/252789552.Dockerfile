FROM phusion/baseimage:0.9.16  
# Docker maintainer  
MAINTAINER Airlangga Cahya Utama <airlangga@durenworks.com>  
  
# Set correct environment variables.  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# Update repository information  
RUN apt-get update -yq && \  
apt-get install -yq build-essential g++ && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

