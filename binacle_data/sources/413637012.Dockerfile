FROM hypermkt/php53-apache

WORKDIR /var/www/html

COPY ./apache2/sites-available/default /etc/apache2/sites-available/default
