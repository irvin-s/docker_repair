FROM composer:1.5.6  
ENV COMPOSER_ALLOW_SUPERUSER 1  
ENV COMPOSER_HOME /tmp  
ENV COMPOSER_VERSION 1.5.6  
WORKDIR /app  
  
RUN composer require league/geotools=0.7.0  
  
COPY reverse.php /app/reverse.php  
COPY no-loop.gpx /app/no-loop.gpx  
COPY loop.gpx /app/loop.gpx  
  
CMD ["composer"]  

