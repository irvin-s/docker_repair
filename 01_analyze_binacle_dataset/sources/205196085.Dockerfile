FROM php:7.0-fpm

WORKDIR /var/www

ENV PHPREDIS_VERSION 2.2.7
ENV NGINX_VERSION 1.9.9-1~jessie

# Install System Dependencies
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
        && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y ca-certificates nginx=${NGINX_VERSION} nano wget git \
        && apt-get clean && apt-get purge \
        && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# nginx vhost and php ini settings
COPY opt/nginx/prod/default.conf /etc/nginx/conf.d/default.conf

COPY . /var/www

# daemon start
EXPOSE 80 443
ENTRYPOINT /usr/local/sbin/php-fpm -D && /usr/sbin/nginx -g 'daemon off;'
