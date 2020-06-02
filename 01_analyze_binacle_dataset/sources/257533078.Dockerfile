FROM php:7.2.0-alpine

MAINTAINER liyu liyu001989@gmail.com

RUN apk update && apk upgrade

# gd 扩展
RUN apk add libjpeg-turbo-dev
RUN apk add libpng-dev
RUN docker-php-ext-install gd

# pdo_mysql 扩展
RUN docker-php-ext-install pdo_mysql
# bamatch
RUN docker-php-ext-install bcmath

# supervisor
RUN apk add supervisor

RUN mkdir -p /etc/supervisor.d

ENTRYPOINT ["supervisord", "--nodaemon", "--configuration", "/etc/supervisord.conf"]
