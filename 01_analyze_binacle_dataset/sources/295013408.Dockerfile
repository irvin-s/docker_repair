FROM alpine:3.9
LABEL maintainer="Alexander Trost <galexrt@googlemail.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk --no-cache add \
        tzdata supervisor nginx php7 php7-fpm php7-pear \
        php7-xml php7-redis php7-bcmath \
        php7-pdo php7-pdo_mysql php7-mysqli php7-mbstring php7-gd php7-mcrypt \
        php7-openssl php7-apcu php7-gmagick php7-xsl php7-zip php7-sockets \
        php7-ldap php7-pdo_sqlite php7-iconv php7-json php7-intl php7-memcached \
        php7-oauth php7-imap php7-gmp \
        g++ make autoconf && \
    cp /usr/share/zoneinfo/UTC /etc/localtime && \
    echo "UTC" > /etc/timezone && \
    mkdir -p /run/nginx

COPY supervisord.conf /etc/supervisord.conf

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
