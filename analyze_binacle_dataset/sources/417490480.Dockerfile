FROM php:7.0.7-apache

RUN apt-get update && apt-get install --yes \
    vim

RUN ln -sd /opt/chardev/10.0/website/public /var/www/chardev
RUN ln /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/

RUN docker-php-ext-install pdo_mysql

ADD chardev.conf /etc/apache2/sites-enabled
ADD php.ini /usr/local/etc/php/
