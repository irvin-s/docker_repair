FROM php:7.2.7-fpm-alpine3.7
RUN apk update; apk upgrade;
RUN apk add freetype-dev libjpeg-turbo-dev libpng-dev zziplib-utils msmtp

# fix iconv issue: https://github.com/docker-library/php/issues/240#issuecomment-327992638
RUN apk add gnu-libiconv --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

RUN docker-php-ext-install mysqli pdo_mysql zip \
  # allow for image uploads inside container
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install gd

# install Mailhog's mhsendmail
ENV GOPATH /usr/src/gocode
RUN apk add --no-cache go git musl-dev
RUN go get github.com/mailhog/mhsendmail && mv ${GOPATH}/bin/mhsendmail /usr/bin
RUN rm -rf ${GOPATH} && apk del go git musl-dev
COPY mail.ini $PHP_INI_DIR/conf.d/

# TODO: install XDebug: https://codereviewvideos.com/course/docker-tutorial-for-beginners/video/docker-php-7-tutorial-7-7-1-and-higher
