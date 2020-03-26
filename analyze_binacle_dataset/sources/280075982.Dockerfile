ARG PHP_BASE_TAG=7.2-cli-alpine3.8
FROM php:$PHP_BASE_TAG

# Install custom packages
RUN apk add --no-cache tzdata zip make openssl linux-headers libstdc++

# Set timezone
ARG TIMEZONE="Europe/Warsaw"
RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime && echo $TIMEZONE > /etc/timezone && \
    "date" && \
    apk del tzdata

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require "hirak/prestissimo:^0.3" --prefer-dist --no-progress --no-suggest --classmap-authoritative --ansi

# Install php extensions
ARG APCU_VERSION=5.1.12
ARG SWOOLE_VERSION=4.2.1
RUN docker-php-source extract && \
    apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS && \
    pecl install apcu-$APCU_VERSION && \
    pecl install swoole-$SWOOLE_VERSION && \
    docker-php-ext-enable apcu swoole && \
    docker-php-ext-install pdo_mysql opcache && \
    apk del .phpize-deps && \
    docker-php-source delete

# Install dockerize
ARG DOCKERIZE_VERSION=v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

# Prepare run scripts
COPY deploy/php-overrides.ini /usr/local/etc/php/conf.d/
COPY deploy/docker-app-entrypoint.sh /usr/local/bin/docker-app-entrypoint
COPY deploy/docker-app-bootstrap.sh /usr/local/bin/docker-app-bootstrap
RUN chmod +x /usr/local/bin/docker-app-entrypoint && \
    chmod +x /usr/local/bin/docker-app-bootstrap

WORKDIR /usr/src/api
ENTRYPOINT ["docker-app-entrypoint"]
CMD ["bin/console", "swoole:server:run"]

# Prevent the reinstallation of vendors at every changes in the source code
ARG COMPOSER_INSTALL_FLAGS="--no-dev"
COPY composer.json composer.lock ./
RUN composer install --prefer-dist --no-autoloader --no-scripts --no-progress --no-suggest --ansi $COMPOSER_INSTALL_FLAGS \
    && composer clear-cache --ansi

COPY . /usr/src/api

RUN mkdir -p var/cache var/log var/sessions public/media/upload && \
    composer dump-autoload --apcu --no-dev --ansi && \
    bin/docker-console assets:install public --ansi && \
    chmod -R 777 var public

ENV TZ=${TIMEZONE} \
    PORT=9501 \
    HOST='127.0.0.1' \
    DOCKERIZE_WAIT_FOR='' \
    JWT_PRIVATE_KEY_PATH='config/jwt/private.pem' \
    JWT_PUBLIC_KEY_PATH='config/jwt/public.pem'

HEALTHCHECK --interval=5s --timeout=1s --start-period=1m \
  CMD curl --fail http://${HOST}:${PORT}/ || exit 1
