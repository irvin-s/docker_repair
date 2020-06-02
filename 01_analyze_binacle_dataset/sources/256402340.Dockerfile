FROM alpine:edge
MAINTAINER Hardware <contact@meshup.net>

RUN echo "@commuedge http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && apk -U add \
    git \
    pcre \
    curl \
    mariadb-client \
    php7@commuedge \
    php7-phar@commuedge \
    php7-openssl@commuedge \
    php7-pdo_mysql@commuedge \
    php7-iconv@commuedge \
    php7-mbstring@commuedge \
    php7-dom@commuedge \
    php7-curl@commuedge \
    php7-intl@commuedge \
    php7-json@commuedge \
    php7-xsl@commuedge \
    php7-zlib@commuedge \
    php7-gd@commuedge \
    php7-tokenizer@commuedge \
    php7-fileinfo@commuedge \
 && cd /tmp \
 && curl -s http://getcomposer.org/installer | php \
 && mv /tmp/composer.phar /usr/bin/composer \
 && chmod +x /usr/bin/composer \
 && rm -rf /var/cache/apk/*

VOLUME /scripts
ENTRYPOINT ["/scripts/startup.sh"]
