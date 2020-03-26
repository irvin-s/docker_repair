FROM ubuntu:14.04  
MAINTAINER Chia-Hsin Hou <marquis.js1215@gmail.com>  
  
RUN sudo apt-get update  
RUN sudo apt-get install -y apache2  
EXPOSE 22 80  
CMD /usr/sbin/apache2ctl -D FOREGROUND  
  

