FROM php:5-apache  
  
MAINTAINER raphael.pinson@camptocamp.com  
  
  
COPY html /var/www/html/r10k-dashboard  
COPY docker-entrypoint.d /docker-entrypoint.d  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["apache2-foreground"]  

