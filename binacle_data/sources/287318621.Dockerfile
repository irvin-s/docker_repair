FROM webdevops/php-nginx:debian-8

MAINTAINER mecab <mecab@misosi.ru>

WORKDIR /app

RUN apt-get update && \
    apt-get install -y --no-install-recommends git memcached mysql-client php5-memcached php5-mysqlnd php5-curl php5-json && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN git clone git://github.com/MPOS/php-mpos.git . && \
    git checkout master;

COPY ./opt/docker/provision/entrypoint.d/8-memcached.sh /opt/docker/provision/entrypoint.d/8-memcached.sh
RUN chmod +x /opt/docker/provision/entrypoint.d/8-memcached.sh
COPY ./opt/docker/etc/nginx/vhost.conf /opt/docker/etc/nginx/vhost.conf
COPY ./opt/docker/etc/nginx/conf.d/01-realip.conf /opt/docker/etc/nginx/conf.d/01-realip.conf
COPY ./mpos/include/classes/coins/coin_yescrypt.class.php /app/include/classes/coins/coin_yescrypt.class.php

RUN chown -R application:application templates/compile templates/cache logs

COPY ./install-schema /bin
RUN chmod +x /bin/install-schema

ENV WEB_DOCUMENT_ROOT /app/public
