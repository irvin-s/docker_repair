FROM nimmis/apache-php5  
  
RUN rm -rf /var/www/html/index.html  
COPY . /var/www/html  
COPY ./resources/default.config.php /var/www/html/resources/config.php  
COPY ./index.php /var/www/html  
  
EXPOSE 80  
VOLUME ["/var/www/html/Data"]  
  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

