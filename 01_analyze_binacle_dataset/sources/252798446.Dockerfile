FROM ubuntu:trusty  
MAINTAINER Danniel Magno <dennyloko@gmail.com>  
  
EXPOSE 3306  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && \  
apt-get install -y mysql-server && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
CMD mysqld  

