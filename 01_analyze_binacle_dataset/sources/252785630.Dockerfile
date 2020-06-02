FROM php:7.2-apache  
  
RUN a2enmod rewrite  
RUN a2enmod vhost_alias  
RUN docker-php-ext-install mysqli pdo_mysql  

