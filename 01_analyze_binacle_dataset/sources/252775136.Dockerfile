FROM wordpress  
  
COPY $PWD/src/root /var/www/html/  
COPY $PWD/src/wp-content /var/www/html/wp-content  
  
COPY $PWD/src/wp-includes /var/www/html/wp-includes  

