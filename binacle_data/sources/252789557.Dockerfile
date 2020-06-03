FROM phusion/baseimage:0.9.18  
# Docker maintainer  
MAINTAINER Airlangga Cahya Utama <airlangga@durenworks.com>  
  
# Set correct environment variables.  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
# Upgrade base image  
RUN apt-get update -yq && \  
apt-get upgrade -yq && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# Update repository information  
RUN apt-get update -yq && \  
apt-get install -yq mysql-server-5.5 eatmydata && \  
rm -rf /var/lib/mysql/mysql && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
# Copy config file  
COPY build /build  
RUN cp -R /build/etc/* /etc && /etc/service/mysqld/run --init  
  
# Expose ports.  
EXPOSE 3306  

