FROM php:7.1-cli  
# FROM php:7.1  
# FROM php:latest  
MAINTAINER Adam Kempler <akempler@gmail.com>  
  
# ENTRYPOINT ["/root/entrypoint.sh"]  
RUN rm /bin/sh \  
&& ln -s /bin/bash /bin/sh  
  
RUN apt-get update \  
&& apt-get install -y \  
libpng12-dev \  
libjpeg-dev \  
libpq-dev \  
libxml2-dev \  
build-essential \  
mysql-client \  
git \  
curl \  
wget \  
vim \  
zip \  
&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \  
&& docker-php-ext-install gd mbstring opcache pdo pdo_mysql pdo_pgsql zip \  
&& apt-get clean  
  
# Install Composer  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer  
  
# Install Drush  
RUN composer global require drush/drush \  
&& ln -s /root/.composer/vendor/bin/drush /usr/local/bin/drush  
  
# Install Drupal Console  
RUN composer require drupal/console:~1.0 --prefer-dist --optimize-autoloader  
RUN composer update drupal/console --with-dependencies  
  
RUN composer global update  
  
#RUN composer global require "squizlabs/php_codesniffer=*"  
# Copy configs  
ADD conf/php.ini $PHP_INI_DIR/conf.d/  
  
WORKDIR /var/www/html  
  
FROM node:9  
# ADD entrypoint.sh /root  
# RUN chmod +x /root/entrypoint.sh  

