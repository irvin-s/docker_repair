FROM php:7-cli
MAINTAINER Tomáš Kukrál <kukratom@fit.cvut.cz>

ENV destdir /usr/src/app

RUN apt-get -y update && \
  apt-get -y install git && \
  apt-get -y clean

COPY . $destdir
WORKDIR $destdir

RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar --no-interaction install

EXPOSE 80
CMD php bin/console server:run 0.0.0.0:80
