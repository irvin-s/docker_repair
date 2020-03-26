FROM phusion/baseimage:0.9.18  
MAINTAINER Damien Garros <dgarros@gmail.com>  
  
RUN apt-get -y update && \  
apt-get -y upgrade  
  
# dependencies  
RUN apt-get -y --force-yes install \  
wget curl build-essential tcpdump tcpreplay  
  
RUN apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN mkdir /data  
WORKDIR /data  
  
ENV HOME /root  
RUN chmod -R 777 /var/log/  
  
VOLUME ["/data"]  
CMD ["/sbin/my_init"]  

