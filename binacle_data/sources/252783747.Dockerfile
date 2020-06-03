FROM php:5.6-apache  
  
COPY . /var/www/html  
  
RUN cd /var/www/html \  
&& mv .htaccess.dist .htaccess \  
&& chown -R www-data:www-data /var/www/html  
  
VOLUME /var/www/html/data  
VOLUME /var/www/html/localconf  
  

