#######################################################  
# This dockerfile builds DHCP #  
# #  
# Author: Demon Tsai #  
# Repository: demontsai/dhcp:latest #  
# Version: 1.0 #  
# #  
#######################################################  
  
FROM ubuntu:14.04  
  
MAINTAINER Demon Tsai demontsai@estinet.com  
  
  
##### Adjust time zone  
RUN echo "Asia/Taipei" > /etc/timezone  
RUN dpkg-reconfigure --frontend noninteractive tzdata  
  
##### Update system and install apps  
RUN apt-get -qq update && apt-get -qqy install vim isc-dhcp-server  
  
##### Environment  
ENV DHCP_CFG /etc/dhcp/dhcpd.conf  
  
##### Install DHCP  
RUN bash -c "cp /etc/dhcp/dhcpd.conf{,.orig}"  
RUN sed -i '/#.*/ d' $DHCP_CFG  
RUN sed -i '/^$/ d' $DHCP_CFG  
  
COPY dhcp_if /usr/sbin/dhcp_if  
COPY dhcp_cfg /usr/sbin/dhcp_cfg  
  
##### Clean  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
##### Command  

