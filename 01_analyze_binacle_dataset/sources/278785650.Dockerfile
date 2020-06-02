FROM php:7.1-apache

RUN a2enmod rewrite
ADD ./apache.conf /etc/apache2/sites-enabled/000-default.conf
