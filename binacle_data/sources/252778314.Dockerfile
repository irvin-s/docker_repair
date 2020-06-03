# -*- mode: ruby -*-  
# vi: set ft=ruby :  
  
FROM jedisct1/phusion-baseimage-latest:16.04  
  
LABEL maintainer "Aquabiota Solutions AB <mapcloud@aquabiota.se>"  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
###############################################  
ENV LANG C.UTF-8  
# Install Java.  
RUN \  
apt-get update && \  
apt-get install -y openjdk-8-jre && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# Clean up APT when done.  
# Define commonly used JAVA_HOME variable  
ENV JAVA_HOME /usr/lib/jvm/java-8-openjre-amd64  

