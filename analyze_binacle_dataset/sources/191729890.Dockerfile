FROM composer:latest AS composer_build
FROM php:7.2-alpine

RUN apk add --no-cache --virtual .persistent-deps \
		git \
		icu-libs \
		libpq \
		postgresql-client \
		libsodium \
		zlib \
		make

ENV APCU_VERSION 5.1.8
RUN set -xe \
	&& apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		libsodium-dev \
		icu-dev \
		postgresql-dev \
		zlib-dev \
	&& docker-php-ext-install \
        	pdo_pgsql \
	        pgsql \
        	bcmath \
	        intl \
	        zip \
	        sodium \
	&& pecl install \
		apcu-${APCU_VERSION} \
	&& docker-php-ext-enable --ini-name 20-apcu.ini apcu \
    && docker-php-ext-enable sodium \
	&& apk del .build-deps

COPY --from=composer_build /usr/bin/composer /usr/bin/composer
RUN ln -s /usr/bin/composer /usr/bin/composer.phar

COPY php/conf.d/park-manager.ini $PHP_INI_DIR/conf.d/park-manager.ini

WORKDIR /srv/www

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER 1

#RUN mkdir -p var/cache var/logs var/sessions \
#	&& composer dump-autoload --classmap-authoritative --no-dev \
#	&& chown -R www-data var
