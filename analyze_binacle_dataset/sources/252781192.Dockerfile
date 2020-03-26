FROM php:7-apache  
  
RUN apt-get update && \  
apt-get install --no-install-recommends -y libpq-dev gettext-base && \  
docker-php-ext-install pgsql  
  
# Settings should not be under web-accessible path!  
COPY entrypoint.sh .htpasswd.tmpl /var/www/  
  
COPY web-root/ /var/www/html/  
  
EXPOSE 80  
ENTRYPOINT ["/var/www/entrypoint.sh"]  
CMD ["apache2-foreground"]  

