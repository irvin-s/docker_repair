FROM debian:stretch-backports  
  
MAINTAINER Josh King <jking@chambana.net>  
  
ENV HOME /root  
ENV DEBIAN_FRONTEND noninteractive  
  
# Configure Apt  
ADD sources.list /etc/apt/sources.list  
ADD distro /etc/apt/preferences.d/distro  
ADD 99default-release /etc/apt/apt.conf.d/99default-release  
  
# Prepare environment  
ADD lib/common.sh /app/lib/common.sh  
ADD bin/bootstrap.sh /app/bin/bootstrap.sh  
RUN chmod 0755 /app/bin/bootstrap.sh  
RUN /app/bin/bootstrap.sh  
  
# Install Chambana.net bashrc  
ADD bashrc /etc/bash.bashrc  
  
ENV LC_ALL C.UTF-8  
ENV TERM xterm  

