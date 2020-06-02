FROM php:7-apache

#RUN apt-get update && apt-get install -y libmemcached-dev 
RUN docker-php-ext-install mysqli

RUN a2enmod rewrite