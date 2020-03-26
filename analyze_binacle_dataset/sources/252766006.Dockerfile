FROM php:7-fpm  
  
MAINTAINER Andreas Kleiber <andreas.kleiber@8select.de>  
  
RUN pecl install apcu-5.1.3 \  
&& docker-php-ext-enable \--ini-name 0-apcu.ini apcu \  
&& pecl install apcu_bc-1.0.3 \  
&& docker-php-ext-enable \--ini-name 1-apc.ini apc \  
&& docker-php-ext-install pdo_mysql  
  
RUN usermod -u 1000 www-data  

