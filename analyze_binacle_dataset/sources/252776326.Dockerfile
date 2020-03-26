FROM mysql:5.5  
MAINTAINER Jérémy Jacquier-Roux <jeremy.jacquier-roux@bonitasoft.org>  
  
# need to increase the packet size set by default to 1M  
RUN echo "max_allowed_packet=16M" >> /etc/mysql/conf.d/docker.cnf  

