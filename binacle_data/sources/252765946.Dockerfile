FROM wordpress:4.8.2-php7.0-apache  
  
EXPOSE 80  
  
USER 5a1l0r  
  
CMD ["apache2-foreground"]

