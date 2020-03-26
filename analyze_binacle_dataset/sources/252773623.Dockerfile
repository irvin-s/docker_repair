FROM php:5.4.45-apache  
  
MAINTAINER Selim BENSENOUCI "selim@openlinux.fr"  
ADD index.php /var/www/html/  
ADD headers.php /var/www/html/  
EXPOSE 80  
CMD ["apache2-foreground"]  

