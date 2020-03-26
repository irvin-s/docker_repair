########################  
# Web-Server Container #  
########################  
  
# Linux Distro and Version  
FROM ubuntu:14.04  
  
# Dockerfile Maintainer  
MAINTAINER Matthew Chipping "boilrig@hotmail.com"  
  
# Update and Upgrade  
RUN apt-get -yqq update  
RUN apt-get -yqq upgrade  
  
# Install Apache2  
RUN apt-get -yqq install apache2  
  
# Install Supervisor  
RUN apt-get -yqq install supervisor  
  
# Add Supervisor File  
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
# Set Working Directory  
WORKDIR /var/www/html  
  
# Apache Specific Commands  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache  
ENV APACHE_PID_FILE /var/run/apache2.pid  
ENV APACHE_RUN_DIR /var/run/apache2  
ENV APACHE_LOCK_DIR /var/lock/apache2  
  
# Apache Specific Directories  
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR  
  
# Expose the Port 80  
EXPOSE 80  
  
# Supervisor for Apache  
CMD ["/usr/bin/supervisord"]

