FROM mediawiki:latest  
  
COPY . /var/www/html  
RUN chown -R www-data:www-data burnerpedia-logo.png  
RUN chown -R www-data:www-data favicon.ico  

