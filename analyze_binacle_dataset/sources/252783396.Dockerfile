#version 1.0.0  
FROM ubuntu:14.04  
MAINTAINER Dean Huakau "deanhuakau@hotmail.co.nz"  
RUN apt-get -yqq update  
RUN apt-get -yqq upgrade  
  
RUN apt-get -yqq install apache2  
  
RUN apt-get -yqq install supervisor  
  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache2  
ENV APACHE_PID_FILE /var/run/apache2.pid  
ENV APACHE_RUN_DIR /var/run/apache2  
ENV APACHE_LOCK_DIR /var/lock/apache2  
  
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR  
EXPOSE 80  
CMD ["/usr/bin/supervisord"]  
  

