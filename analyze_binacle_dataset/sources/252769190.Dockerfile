FROM ubuntu:16.04  
MAINTAINER angelomsq <angelomsq@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
curl \  
apache2 \  
php7.0 \  
libapache2-mod-php7.0 \  
php7.0-mcrypt \  
php7.0-mbstring \  
php7.0-cli \  
php7.0-curl \  
php7.0-json \  
php7.0-mysql \  
php7.0-pgsql \  
php7.0-sqlite3 \  
php7.0-ldap \  
php-imagick \  
php7.0-xml \  
php7.0-zip \  
php7.0-gd  
  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache2  
env APACHE_PID_FILE /var/run/apache2.pid  
env APACHE_RUN_DIR /var/run/apache2  
env APACHE_LOCK_DIR /var/lock/apache2  
  
COPY config/php.ini /etc/php/7.0/cli/  
COPY config/php.ini /etc/php/7.0/apache2/  
COPY config/apache2.conf /etc/apache2/  
COPY config/000-default.conf /etc/apache2/sites-available/  
  
WORKDIR /var/www  
# Toss our composer includes into the PATH (for phpunit)  
ENV PATH /var/www/vendor/bin:$PATH  
  
CMD ["apachectl", "-D", "FOREGROUND"]  
  
Expose 80 443  

