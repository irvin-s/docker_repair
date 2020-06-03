FROM debian:8.4  
  
MAINTAINER Antarkt Inc.  
LABEL inc.antarkt.santopanel.role=os  
LABEL vendor=antarkt.inc  
  
# Update packages  
RUN apt-get update && \  
apt-get upgrade -y && \  
# Clean up  
apt-get clean -y && \  
apt-get autoclean -y && \  
apt-get autoremove -y && \  
apt-get --list-cleanup update && \  
rm -rf /usr/share/locale/* && \  
rm -rf /var/cache/debconf/*-old && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /usr/share/doc/*  

