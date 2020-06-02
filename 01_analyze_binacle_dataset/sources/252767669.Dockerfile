FROM wordpress:4.8.1-php7.1-apache  
  
RUN docker-php-ext-install zip  
  
RUN sed -i 's/-Indexes/+Indexes/g' /etc/apache2/conf-enabled/docker-php.conf  
  
RUN echo "max_execution_time = 360" >> /usr/local/etc/php/php.ini  

