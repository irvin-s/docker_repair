FROM debian:wheezy  
MAINTAINER Cheng Jeng<s100062314@m100.nthu.edu.tw>  
  
RUN apt-get update && \  
apt-get install -y \  
apache2  
EXPOSE 80  
ENTRYPOINT ["/usr/sbin/apachectl", "-D", "FOREGROUND"]  
  

