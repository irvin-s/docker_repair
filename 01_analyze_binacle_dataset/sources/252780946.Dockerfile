FROM php:5.4-apache  
  
ADD run-joomla.sh /usr/local/bin/  
RUN chmod a+x /usr/local/bin/run-joomla.sh  
  
VOLUME ["/var/www/html/"]  
VOLUME ["/var/www/html/images"]  
CMD ["/usr/local/bin/run-joomla.sh"]  

