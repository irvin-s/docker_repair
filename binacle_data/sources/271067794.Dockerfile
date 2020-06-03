FROM php:7.1-fpm

ARG gd=0
ARG xdebug=1
ARG mysql=1

RUN mkdir -p /usr/local/bin \
    && curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony \
    && chmod a+x /usr/local/bin/symfony

# Install recommended extensions for Symfony
RUN apt-get update && apt-get install -y \
        libicu-dev \
    && docker-php-ext-install \
        intl \
        opcache \
    && docker-php-ext-enable \
        intl \
        opcache

# Install db extensions
RUN if [ "$mysql" -eq "1" ]; then \
        docker-php-ext-install pdo pdo_mysql \
    ;fi

# Install gd extensions
RUN if [ "$gd" -eq "1" ]; then \
        apt-get install -y \
            libfreetype6-dev \
            libjpeg62-turbo-dev \
            libpng12-dev \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install -j$(nproc) gd \
    ;fi


# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install useful tools for composer
RUN apt-get install -y git unzip

# Install XDebug
RUN if [ "$xdebug" -eq "1" ]; then \
        pecl install xdebug-2.5.0 \
            && docker-php-ext-enable xdebug \
            && echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.default_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.remote_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.remote_autostart = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.remote_connect_back = 0" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.profiler_enable = 1" >> /usr/local/etc/php/conf.d/xdebug.ini \
            && echo "xdebug.remote_host = 127.0.0.1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    ;fi

# Useful alias
RUN echo 'alias sf="php app/console"' >> ~/.bashrc
RUN echo 'alias sf3="php bin/console"' >> ~/.bashrc

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
WORKDIR /var/www/app
CMD ["php-fpm"]