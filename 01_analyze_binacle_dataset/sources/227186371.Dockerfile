FROM nginx:alpine

MAINTAINER Mahmoud Zalt <mahmoud@zalt.me>

ARG NGINX_HOST_HTTP_PORT_1=80
ARG NGINX_HOST_HTTP_PORT_2=443
ARG NGINX_HOST_HTTP_PORT_3=8080

ADD nginx.conf /etc/nginx/

ARG PHP_UPSTREAM=php-fpm

# fix a problem--#397, change application source from dl-cdn.alpinelinux.org to aliyun source.
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash \
    && adduser -D -H -u 1000 -s /bin/bash www-data \
    && rm /etc/nginx/conf.d/default.conf \
    && echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" > /etc/nginx/conf.d/upstream.conf

CMD ["nginx"]

EXPOSE ${NGINX_HOST_HTTP_PORT_1} ${NGINX_HOST_HTTP_PORT_2} ${NGINX_HOST_HTTP_PORT_3}
