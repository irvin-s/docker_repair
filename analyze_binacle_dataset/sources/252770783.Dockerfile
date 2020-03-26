FROM ubuntu:16.04  
MAINTAINER agate.hao@gmail.com  
  
RUN apt-get update && apt-get install -y ntp  
  
EXPOSE 123/udp  
  
CMD ["/usr/sbin/ntpd", "-d"]  

