FROM alpine:3.4
Maintainer Pan Jiabang <panjiabang@gmail.com>

RUN apk --update --no-cache add wget python3 nginx && \
    pip3 --no-cache-dir install chaperone envtpl && mkdir -p /etc/chaperone.d && \
    apk --update --repository http://nl.alpinelinux.org/alpine/edge/community/ --no-cache add php7 php7-fpm php7-ctype php7-curl php7-dom php7-gd php7-iconv php7-json php7-mcrypt php7-openssl php7-posix php7-sockets php7-xml php7-xmlreader php7-zip php7-mbstring php7-session && \
    wget -c --no-check-certificate https://github.com/getgrav/grav/releases/download/1.1.3/grav-admin-v1.1.3.zip && \
    mkdir -p /var/www && unzip -q /grav-admin-v1.1.3.zip -d /var/www && \
    rm -rf /var/www/html && mv /var/www/grav-admin /var/www/html && rm /grav-admin-v1.1.3.zip

RUN apk --no-cache add ruby && \
    echo 'gem: --no-document' >> ~/.gemrc && \
    gem install sass && \
    gem sources -c

# RUN deluser nobody && addgroup -g 1000 nobody && adduser -D -u 1000 -G nobody nobody

COPY config/chaperone.conf /etc/chaperone.d/chaperone.conf
COPY config/nginx.conf /etc/nginx/nginx.conf.tpl
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/grav.conf
COPY config/www.conf /etc/php7/php-fpm.d/www.conf
COPY config/php.ini /etc/php7/conf.d/grav.ini

USER root

EXPOSE 80

ENTRYPOINT ["/usr/bin/chaperone"]
