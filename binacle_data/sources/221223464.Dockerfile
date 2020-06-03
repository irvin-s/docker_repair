FROM composer:1.6.4

ARG composer_dev_arg

RUN apk add --no-cache \
    patch

COPY composer.json \
    composer.lock \
    ./

RUN composer --no-interaction install ${composer_dev_arg} --ignore-platform-reqs --no-autoloader --no-suggest --prefer-dist

COPY test/ test/
COPY src/ src/

RUN composer --no-interaction dump-autoload ${composer_dev_arg} --classmap-authoritative
