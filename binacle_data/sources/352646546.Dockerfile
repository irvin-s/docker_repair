# Serveur apache
FROM php:5.6.11-fpm
MAINTAINER Arnaud POINTET <arnaud.pointet@gmail.com>

RUN apt-get update && apt-get install -y zlib1g-dev libicu-dev g++ libmcrypt-dev
RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN curl https://pecl.php.net/get/mongo-1.5.8.tgz > /tmp/mongo.tgz
RUN tar -xpzf /tmp/mongo.tgz
RUN mv mongo-1.5.8 /usr/src/php/ext
RUN docker-php-ext-install mongo-1.5.8

RUN apt-get update \
    &&  docker-php-ext-install mbstring pdo_mysql mcrypt mysql
   
ADD conf/www.conf /etc/php5/fpm/pool.d/www.conf
ADD conf/30-custom.ini /usr/local/etc/php/conf.d/30-custom.ini

RUN useradd arnaud -p arnaud

RUN apt-get update
RUN apt-get -y install wget

RUN wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb 
RUN apt-get -y install xfonts-base xfonts-75dpi xfonts-utils fontconfig libxext6 libfontconfig1 libjpeg62-turbo libx11-6 libxrender1
RUN dpkg -i wkhtmltox-0.12.2.1_linux-jessie-amd64.deb
RUN rm wkhtmltox-0.12.2.1_linux-jessie-amd64.deb

RUN apt-get -y install locales
# Set the locale
RUN locale-gen fr_FR.utf8
ENV LANG fr_FR.utf8
ENV LANGUAGE fr_FR:fr
ENV LC_ALL fr_FR.utf8

ENTRYPOINT php-fpm --nodaemonize

VOLUME /var/www

WORKDIR /var/www
