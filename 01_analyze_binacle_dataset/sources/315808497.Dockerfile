FROM php:7.3-alpine as builder

RUN echo 'date.timezone = "UTC"' > /usr/local/etc/php/php.ini \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php --filename composer --install-dir=/usr/bin/ \
	&& php -r "unlink('composer-setup.php');" \
	&& chmod +x /usr/bin/composer \
    && apk add --no-cache --update gmp-dev icu-dev \
    && docker-php-ext-install intl gmp pcntl

COPY src /app/src
COPY bin /app/bin
COPY composer.* /app/

RUN cd /app && composer install --no-dev --prefer-dist --optimize-autoloader --no-interaction

FROM php:7.3-alpine

ENV HOST_MANAGER_CERT_ORGANIZATION_NAME='Docker HostManager' \
    HOST_MANAGER_CERT_COMMON_NAME='Docker HostManager Root CA' \
    HOST_MANAGER_CERT_COUNTRY_NAME='FR' \
    HOST_MANAGER_CERT_STATE_OR_PROVINCE_NAME='Paris' \
    HOST_MANAGER_CERT_LOCALITY_NAME='Paris' \
    HOST_MANAGER_DATA_PATH='/data' \
    HOST_MANAGER_HOSTS_FILE_PATH='/host/etc/hosts'

RUN echo 'date.timezone = "UTC"' > /usr/local/etc/php/php.ini \
    && apk add --no-cache --update --virtual .php-deps gmp-dev icu-dev \
    && apk add --no-cache --update su-exec gmp icu-libs \
    && docker-php-ext-install intl gmp pcntl \
    && apk del --no-cache .php-deps

COPY --from=builder /app /app

RUN apk add --no-cache tini
ENTRYPOINT ["/sbin/tini", "--"]

CMD ["/app/bin/docker-hostmanager"]
