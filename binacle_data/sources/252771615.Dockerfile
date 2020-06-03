  
FROM php:7-apache  
  
WORKDIR /var/www/html/  
  
COPY angular-filemanager/ /var/www/html/  
  
RUN mkdir -p /var/www/files; chmod 777 /var/www/files  
VOLUME /var/www/files  
  

