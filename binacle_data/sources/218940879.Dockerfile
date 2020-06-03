FROM php:7.1-fpm-alpine
MAINTAINER Louis TREZZINI <louis.trezzini@ponts.org>

RUN addgroup php && adduser -D -G php php
RUN mkdir /app && chown php:php /app && chmod 700 /app
WORKDIR /app

RUN apk --no-cache add bash git libmcrypt-dev libjpeg-turbo-dev libpng-dev freetype-dev

RUN docker-php-ext-install pdo pdo_mysql iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd


COPY php-fpm.conf /etc/php-fpm/www.conf

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer config --global repo.packagist composer https://packagist.org

# Set timezone
RUN ln -snf /usr/share/zoneinfo/Europe/Paris /etc/localtime && echo Europe/Paris > /etc/timezone && \
    printf '[PHP]\ndate.timezone = "Europe/Paris"\n',  > /usr/local/etc/php/conf.d/tzone.ini

USER php

ARG BUILD_APP_ENV=prod
ENV APP_ENV=$BUILD_APP_ENV
COPY --chown=php:php composer.json composer.lock symfony.lock /app/
RUN echo $BUILD_APP_ENV && composer install --no-scripts $( [[ "$BUILD_APP_ENV" == "prod" ]] && echo "--no-ansi --no-dev --no-interaction --no-progress --optimize-autoloader")

COPY --chown=php:php . /app/

ARG VERSION_HASH
ARG VERSION_TAG
RUN /app/create-circle-version.sh

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["php-fpm"]
EXPOSE 9000
