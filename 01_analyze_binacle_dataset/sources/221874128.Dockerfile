FROM alpine:latest
MAINTAINER Barra <bxt@mondedie.fr>

ENV DOKUWIKI_VERSION 2017-02-19a
ENV GID=1001 UID=1001

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U add \
    nginx \
    supervisor \
    tini@commuedge \
    php7-fpm@commuedge \
    php7-curl@commuedge \
    php7-iconv@commuedge \
    php7-xml@commuedge \
    php7-dom@commuedge \
    php7-json@commuedge \
    php7-zlib@commuedge \
    php7-pdo_mysql@commuedge \
    php7-pdo_sqlite@commuedge \
    php7-sqlite3@commuedge \
    php7-session@commuedge \
    tar \
    curl \
  && mkdir -p /var/www \
  && cd /var/www \
  && curl -O -L "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz" \
  && tar xzf "dokuwiki-${DOKUWIKI_VERSION}.tgz" --strip 1 \
  && rm "dokuwiki-$DOKUWIKI_VERSION.tgz"

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY startup /usr/local/bin/startup

RUN chmod +x /usr/local/bin/startup
EXPOSE 80
VOLUME [ \
    "/var/www/data/pages", \
    "/var/www/data/meta", \
    "/var/www/data/media", \
    "/var/www/data/media_attic", \
    "/var/www/data/media_meta", \
    "/var/www/data/attic", \
    "/var/www/conf", \
    "/var/log" \
]
CMD ["/sbin/tini","--","startup"]
