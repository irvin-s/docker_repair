FROM php:7.0-apache

MAINTAINER Fernando Moreira <nandomoreira.me@gmail.com>

RUN apt-get update
RUN apt-get install -y \
      curl \
      wget \
      vim \
      mysql-client \
      libmysqlclient-dev && \
    apt-get clean

RUN a2enmod rewrite

RUN docker-php-ext-install mysqli

ADD configs/docker.conf /etc/apache2/sites-enabled/

USER root
WORKDIR /var/www/

RUN rm -rf ./html/
RUN wget --quiet https://wordpress.org/latest.tar.gz
RUN tar -xzf latest.tar.gz
RUN mv -f wordpress html

WORKDIR /var/www/html

ADD configs/.htaccess ./
ADD configs/wp-config.* ./

RUN chown -R www-data: /var/www/html
