FROM debian:stretch-slim  
  
MAINTAINER Dave Dobson <ddobson@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
ENV APACHE_RUN_USER=www-data \  
APACHE_RUN_GROUP=www-data \  
APACHE_LOG_DIR=/var/log/apache2 \  
APACHE_LOCK_DIR=/var/lock/apache2 \  
APACHE_PID_FILE=/var/run/apache2.pid  
  
RUN apt-get update && \  
apt-get -y install --no-install-recommends \  
apache2 \  
php \  
libapache2-mod-php && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN ln -sf /dev/stdout /var/log/apache2/access.log  
RUN ln -sf /dev/stderr /var/log/apache2/error.log  
  
RUN a2enmod php7.0  
  
EXPOSE 80  
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

