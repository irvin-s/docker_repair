FROM php:5.5  
RUN pear install doc.php.net/PhD  
  
WORKDIR /app  
COPY php.ini /usr/local/etc/php/conf.d/0-php.ini  

