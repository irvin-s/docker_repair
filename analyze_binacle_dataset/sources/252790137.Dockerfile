from php:7-fpm  
  
RUN mkdir -p /usr/local/bin  
RUN apt-get update && apt-get install -y -q mariadb-client supervisor  
  
RUN docker-php-ext-install pdo pdo_mysql mysqli  
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony  
RUN chmod a+x /usr/local/bin/symfony  
  
COPY appli/ /var/www/html  
EXPOSE 8000 3306  
ENTRYPOINT php bin/console server:run 0.0.0.0:8000  

