FROM ubuntu:16.04

ADD . /var/www/

WORKDIR /var/www
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
 && apt-get install -y php libapache2-mod-php7.0 apache2 curl php-pgsql php-xml php-mail postgresql postfix git \
 && a2enmod rewrite \
 && cp /var/www/apache.conf /etc/apache2/sites-available/000-default.conf \
 && mv /var/www/html /var/www/public \
 && curl -sS https://getcomposer.org/installer \
  | php -- --install-dir=/usr/local/bin --filename=composer \
 && composer -n install \
 && useradd c5b8865cc6d98898f391c911f4c371a3
RUN rm -rf /var/lib/apt/lists/*
 
 
