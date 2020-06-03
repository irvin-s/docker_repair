FROM phusion/baseimage:latest  
  
MAINTAINER Accur8 Software "https://github.com/accur8"  
# make sure we have the latest security patches  
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"  
RUN apt-get install -y \  
curl \  
fish \  
git \  
httping \  
mtr \  
nano \  
rsync \  
screen \  
unison \  
wget  
  
  
RUN echo "nameserver 10.10.0.1" > /etc/resolv.conf  
  
  
CMD ["/sbin/my_init"]  
  
  
#  
# possibly  
# mvn  
# java  
# zinc  
# scala  
# imm (scala repl)  
#  
# == build with ==  
#  
# docker build -t a8_base_image .  

