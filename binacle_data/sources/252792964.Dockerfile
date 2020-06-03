FROM debian:jessie  
MAINTAINER Chia-Hsin Hou <marquis.js1215@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y apache2 && \  
apt-get clean  
  
ENV APACHE_SERVERNAME localhost  
  
EXPOSE 22 80  
CMD /usr/sbin/apache2ctl -D FOREGROUND  
  

