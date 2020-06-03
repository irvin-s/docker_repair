FROM wordpress  
  
COPY wp-config.php /var/www/html/wp-config.php  
COPY .htaccess /var/www/html/.htaccess

