# Squid3  
#  
# A VERY simple squid proxy server.  
FROM phusion/baseimage:0.9.22  
MAINTAINER CosmicQ <cosmicq@cosmicegg.net>  
  
ENV HOME /root  
ENV LANG en_US.UTF-8  
RUN locale-gen en_US.UTF-8  
  
RUN ln -s -f /bin/true /usr/bin/chfn  
  
# Install Squid  
RUN apt-get update && apt-get -y upgrade  
RUN apt-get -y install squid3 && apt-get clean  
  
ADD squid.conf /etc/squid/squid.conf  
ADD update_squid.sh /etc/my_init.d/01_update_squid.sh  
ADD start_squid.sh /etc/service/squid/run  
  
EXPOSE 3128  
VOLUME ["/var/spool/squid3"]  
  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  

