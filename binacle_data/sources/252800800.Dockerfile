FROM wordpress:latest  
  
#VOLUME /var/www/html/wp-content/  
ADD . /var/www/html/wp-content/themes/mountainhunter/  
  
RUN chmod -R 777 /var/www/html/

