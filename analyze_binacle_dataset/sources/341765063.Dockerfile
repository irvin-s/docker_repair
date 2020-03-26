FROM php:7.2.1-fpm-alpine3.7

RUN apk add --no-cache --virtual .persistent-deps \
    geoip \
    yarn \
    freetype \
    tzdata

RUN set -xe \
	&& apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
        freetype-dev \
        geoip-dev \
        postgresql-dev \
        libpng \
        libjpeg-turbo

# Install Supervisor
RUN set -xe \
    && apk add --no-cache -u python py-pip \
    && pip install supervisor==3.3.1

# Install required PHP extensions
RUN set -xe \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pgsql pdo_pgsql  \
    && pecl install mongodb \
    && pecl install xdebug-2.6.0beta1 \
    && echo 'no' | pecl install redis  \
    && pecl install geoip-1.1.1

RUN  set -xe \
    && echo 'extension=geoip.so'     > $PHP_INI_DIR/conf.d/geoip.ini \
    && echo 'extension=redis.so'     > $PHP_INI_DIR/conf.d/redis.ini \
    && echo 'extension=mongodb.so'   > $PHP_INI_DIR/conf.d/mongodb.ini \
    && { \
        echo 'zend_extension=xdebug.so'; \
        echo 'xdebug.idekey=xdebug'; \
        echo 'xdebug.max_nesting_level=500'; \
        echo 'xdebug.remote_enable=On'; \
        echo 'xdebug.remote_connect_back=1'; \
        echo 'xdebug.remote_port=9000'; \
    } > $PHP_INI_DIR/conf.d/xdebug.ini

RUN set -ex \
    && cd /tmp \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer \
    && wget http://phar.phpunit.de/phpunit-6.5.phar \
    && mv phpunit-6.5.phar /usr/local/bin/phpunit \
    && chmod +x /usr/local/bin/phpunit

COPY ./config/docker/php/dev/php.ini $PHP_INI_DIR/
COPY ./config/docker/php/dev/php-fpm/www.conf $PHP_INI_DIR/php-fpm.d/

# Add a cron entry for Laravel's command scheduler
RUN set -ex \
    && crontab -l | { cat; echo "* * * * * php /var/www/html/artisan schedule:run 2>&1 | /usr/bin/logger -t laravel_scheduler"; } | crontab -

COPY ./config/docker/php/dev/supervisord.conf /etc/supervisord.conf

ADD . /var/www/html

RUN set -xe \
    && cd /var/www/html \
    && yarn install \
    && composer install --no-progress

# Set container entrypoint
COPY ./config/docker/php/dev/entrypoint.sh /
RUN chmod +x /entrypoint.sh
CMD ["/entrypoint.sh"]

VOLUME /var/www