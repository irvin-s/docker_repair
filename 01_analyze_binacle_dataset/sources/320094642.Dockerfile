FROM alpine:latest
MAINTAINER Barra <bxt@mondedie.fr>

ENV GID=1001 UID=1001
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
 && apk -U add \
    nginx \
    ffmpeg \
    supervisor \
    tini@commuedge \
    php7-fpm@commuedge \
    php7-curl@commuedge \
    php7-iconv@commuedge \
    php7-xml@commuedge \
    php7-dom@commuedge \
    php7-json@commuedge \
    php7-zlib@commuedge \
    php7-session@commuedge \
    php7 \
    php7-phar \
    gnu-libiconv@testing \
    tar \
    git \
    curl \
  && mkdir -p /var/www \
  && cd /var/www \
  && curl -L https://getcomposer.org/composer.phar -o /usr/local/bin/composer && chmod a+x /usr/local/bin/composer \
  && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl && chmod a+x /usr/local/bin/youtube-dl \
  && git clone "https://github.com/PixiBixi/Youtube-dl-WebUI.git" youtube-dl && cd youtube-dl && composer config -g -- disable-tls true && composer dump-autoload \
  && rm -rf /var/cache/apk/* /tmp/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php7/php-fpm.conf
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY startup /usr/local/bin/startup

RUN chmod +x /usr/local/bin/startup
EXPOSE 80
VOLUME /var/www/youtube-dl/downloads

CMD ["/sbin/tini","--","startup"]

