FROM composer as builder

ARG WORKDIR="/app"

WORKDIR ${WORKDIR}

COPY composer.json composer.lock ${WORKDIR}/
RUN composer install  \
    --ignore-platform-reqs \
    --no-ansi \
    --no-autoloader \
    --no-dev \
    --no-interaction \
    --no-scripts

COPY . ${WORKDIR}
RUN composer dump-autoload --no-dev --optimize --classmap-authoritative


FROM php:7.2-apache

LABEL maintainer="Jose Armesto <jose@armesto.net>"

ARG WORKDIR="/app"

WORKDIR /app

EXPOSE 80

RUN pecl install xdebug-2.6.0; \
    docker-php-ext-enable xdebug; \
    usermod -u 1000 www-data; \
    a2enmod rewrite; \
    chown -R www-data:www-data /var/www/html

COPY --from=builder ${WORKDIR} /var/www/html/
