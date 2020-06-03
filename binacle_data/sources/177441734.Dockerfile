FROM nginx:alpine
MAINTAINER Phil Estes <estesp@gmail.com>

RUN addgroup -g 999 docker
RUN addgroup nginx docker
COPY forwarder.conf /etc/nginx/conf.d/default.conf

