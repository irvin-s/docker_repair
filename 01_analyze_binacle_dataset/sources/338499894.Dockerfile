FROM php:7.2-fpm

RUN apt-get update \
    && apt-get install -y libpq-dev libgmp-dev git zip iproute2 \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
        gmp \
        mbstring \
        opcache \
        pdo pdo_pgsql \
        bcmath

RUN yes | pecl install apcu xdebug \
        && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/apcu.ini \
        && echo "apc.enable_cli=1" >> /usr/local/etc/php/conf.d/apcu.ini \
        && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
        && echo "opcache.memory_consumption=1024" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.interned_strings_buffer=8" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.max_accelerated_files=20000" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.revalidate_freq=600" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.fast_shutdown=1" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/opcache.ini \
        && echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/opcache.ini

ENV PATH "/composer/vendor/bin:$PATH"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

WORKDIR /app

COPY docker/php/scripts/composer_installer.sh /composer/
RUN /composer/composer_installer.sh && \
    rm /composer/composer_installer.sh && \
    composer --ansi --version --no-interaction
COPY composer.json composer.lock /app/
RUN composer install --no-interaction --no-progress --no-ansi --no-autoloader --no-scripts

CMD ["bash", "bin/boot"]

COPY docker/php/config/www.conf /usr/local/etc/php-fpm.d/www.conf

COPY . /app/

RUN composer dump --optimize --apcu
