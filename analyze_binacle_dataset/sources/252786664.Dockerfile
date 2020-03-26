FROM php:apache  
MAINTAINER Denis Pettens <denis.pettens@gmail.com>  
  
# Install pdo mysql driver  
RUN docker-php-ext-install pdo pdo_mysql  
  
EXPOSE 80  
COPY ./public_html/ /var/www/html/  

