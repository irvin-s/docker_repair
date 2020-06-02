# Serveur apache
FROM nginx:latest
MAINTAINER Arnaud POINTET <arnaud.pointet@gmail.com>

ADD conf.d /etc/nginx/conf.d

EXPOSE 80

VOLUME /var/www

RUN useradd arnaud -p arnaud

WORKDIR /var/www
