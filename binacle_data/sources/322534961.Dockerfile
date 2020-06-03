FROM php:7.2-apache

RUN apt update && apt install -y gdal-bin && a2enmod rewrite && a2enmod ssl

COPY . /var/www/html/

VOLUME ["/var/www/html/config/projects"]
