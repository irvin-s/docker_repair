FROM php:7.0-fpm-alpine

RUN apk add --no-cache postgresql-dev

RUN docker-php-ext-install \
        bcmath             \
        mbstring           \
        zip                \
        opcache            \
        pdo pdo_pgsql

WORKDIR /srv
COPY . /srv
CMD ["sh", "bin/boot"]
