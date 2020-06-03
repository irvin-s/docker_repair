FROM arnaudpiroelle/base  
MAINTAINER Arnaud Piroelle "piroelle.arnaud@gmail.com"  
RUN apt-get update && apt-get install -y apache2  
  
ENV APACHE_RUN_USER=www-data  
ENV APACHE_RUN_GROUP=www-data  
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid  
ENV APACHE_RUN_DIR=/var/run/apache2  
ENV APACHE_LOCK_DIR=/var/lock/apache2  
ENV APACHE_LOG_DIR=/var/log/apache2  
  
RUN mkdir -p /var/lock/apache2  
  
EXPOSE 80  
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]  

