FROM wordpress  
COPY ./wp-content/ /var/www/html/wp-content  
VOLUME /var/www/html/wp-content/uploads

