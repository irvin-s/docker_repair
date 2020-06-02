FROM debian:jessie
MAINTAINER Clément Schreiner <clement@mux.me>

RUN groupadd -r debile && useradd -r -g debile -d /srv/debile debile

RUN apt-get update && apt-get install -y nginx

COPY nginx.conf /etc/nginx/

VOLUME /var/log/nginx
EXPOSE 80

CMD nginx
