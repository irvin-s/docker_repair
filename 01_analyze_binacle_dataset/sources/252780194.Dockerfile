#Start with the official PHP image  
FROM php:7.0-apache  
  
WORKDIR /var/www/html  
COPY html /var/www/html  
COPY config.json /var/www/html/config.json  
EXPOSE 80  
ENV CONTAINER_NAME sample_php_application  
COPY linter.sh /usr/local/bin/linter.sh  
RUN chmod +x /usr/local/bin/linter.sh \  
&& sleep 5 \  
&& /usr/local/bin/linter.sh /var/www/html \  
&& chown www-data:www-data /var/www/html/config.json  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

