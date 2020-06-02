FROM php:7.0-fpm

COPY ./config/php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        git \
        curl \
        wget \
        apt-utils \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        sendmail \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
        gd \
        iconv \
        mcrypt \
        fileinfo \
        json \
        mbstring \
        mysqli \
        opcache \
        pdo \
        pdo_mysql \
        zip \
        intl \
        dom \
        xml \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./script/docker-php-sendmail-entrypoint.sh /usr/local/bin/

RUN chmod 777 /usr/local/bin/docker-php-sendmail-entrypoint.sh

WORKDIR /app

ENTRYPOINT ["docker-php-sendmail-entrypoint.sh"]

CMD ["php-fpm"]