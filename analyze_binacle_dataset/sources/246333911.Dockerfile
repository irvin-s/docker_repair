FROM php:7.1-fpm

WORKDIR /app/

RUN apt-get update \
    && apt-get install -y libpq-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
        mbstring \
        zip \
        opcache \
        bcmath \
        pdo pdo_pgsql

RUN yes | pecl install apcu xdebug \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
    && echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/apcu.ini \
    && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini

RUN apt-get update \
    && apt-get install -y cron \
    && rm -rf /var/lib/apt/lists/*

ADD composer.json composer.lock app.php /app/
ADD vendor/ /scripts/vendor/
ADD bin/ /scripts/bin/
ADD app/ /scripts/app/
ADD tests/ /scripts/tests/

CMD ["bash", "bin/boot"]
