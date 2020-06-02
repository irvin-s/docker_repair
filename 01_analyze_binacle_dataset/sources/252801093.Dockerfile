# See https://github.com/docker-library/docs/tree/master/php#pecl-extensions  
FROM php:7.1-fpm  
RUN pecl install redis \  
&& pecl install xdebug \  
&& docker-php-ext-enable redis xdebug  
  
RUN apt-get update && apt-get install -y \  
zip \  
unzip \  
nginx  
  
RUN apt-get update && apt-get install -y sudo \  
htop \  
vim \  
iputils-ping \  
net-tools \  
mysql-client \  
sqlite3 \  
postgresql-client \  
mc  
  
COPY nginx/* /etc/nginx/sites-enabled/  
COPY php-fpm/xdebug/xdebug.ini /etc/php/7.1/mods-available/xdebug.ini  
  
# WORKDIR /var/www/html  
ENV TERM xterm

