FROM php:7.1.3-fpm-alpine

RUN apk add --no-cache \
    libpng libpng-dev libjpeg-turbo-dev freetype-dev \
    libmcrypt-dev libintl icu icu-dev libxml2-dev \
    libxslt-dev \
    && docker-php-ext-configure gd  \
        --with-jpeg-dir=/usr/include/ --with-freetype-dir=/usr/include \
    && docker-php-ext-install \
        gd mcrypt pdo_mysql mysqli intl zip \
        xsl bcmath  soap xmlrpc opcache \
    && docker-php-ext-enable mysqli

ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=www-data --with-fpm-group=www-data 

RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer

# Install mailhog.
RUN curl -fSL "https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

COPY ./mailhog.ini /usr/local/etc/php/conf.d/mailhog.ini

RUN apk add --update --no-cache \
        curl \
        g++ \
        make \
        autoconf \
    && docker-php-source extract \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && docker-php-source delete \
    && rm -rf /tmp/*

COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY ./opcache.ini /usr/local/etc/php/conf.d/opcache.ini
COPY ./improve.ini /usr/local/etc/php/conf.d/improve.ini

CMD ["php-fpm"]
