FROM dockerbishnu/php_apache:init  
  
COPY ./resource /var/www/html  
  
WORKDIR /var/www/html  
  
ADD ./000-default.conf /etc/apache2/sites-available

