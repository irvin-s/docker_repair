FROM php:7.0.9-apache  
  
RUN a2enmod rewrite && \  
docker-php-ext-install mysqli gettext  
  
ENV APP_HOME /var/www/html  
  
WORKDIR $APP_HOME  
COPY . $APP_HOME  
  
EXPOSE 80  

