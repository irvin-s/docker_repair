FROM php:7.2-apache

RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf
RUN cat /etc/apache2/ports.conf
RUN chmod 777 /var/run/apache2

COPY *.js /var/www/html/
COPY *.php /var/www/html/
COPY *.css /var/www/html/
