FROM php:7.0-alpine

COPY . /var/app
WORKDIR /var/app

RUN apk update
RUN apk add --update zlib-dev
RUN docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) iconv
RUN rm -rf /tmp/*

EXPOSE 1337

ENTRYPOINT ["php", "./example/app-prod-mode.php"]
