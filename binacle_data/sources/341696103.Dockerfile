FROM php:7.1.26-fpm-stretch

LABEL maintainer="Bert Oost <hello@bertoost.com>"

# Create docker PHP user.
RUN adduser \
   -u 1000 \
   --system \
   --shell /bin/bash \
   --group \
   --disabled-password \
   php

RUN mkdir -p /var/www/html \
    && chown php:php /var/www/html

# Install modules
RUN apt-get update \
    && apt-get install -y \
        wget \
        build-essential \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        imagemagick \
        git \
        locales \
        libssl-dev \
        re2c \
        libmcrypt-dev \
        zip \
        unzip \
        libicu57 \
        libmagickwand-6.q16-dev --no-install-recommends \
        libicu-dev \
        g++ \
        ssmtp \
        libyaml-dev \
        gettext \
        openssh-client \
        pdftk \
        apt-transport-https \
        mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install \
        iconv \
        mcrypt \
        gd \
        pdo \
        pdo_mysql \
        mysqli \
        mbstring \
        soap \
        sysvmsg \
        sysvshm \
        sysvsem \
        intl \
        opcache \
        pcntl \
        shmop \
        zip \
        gettext \
        sockets \
        exif

RUN echo 'en_US ISO-8859-1\n\
    en_US.ISO-8859-15 ISO-8859-15\n\
    en_US.UTF-8 UTF-8\n\
    nl_NL ISO-8859-1\n\
    nl_NL.UTF-8 UTF-8\n\
    nl_NL@euro ISO-8859-15\n'\
    >> /etc/locale.gen && /usr/sbin/locale-gen

RUN ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin/

RUN wget https://download.libsodium.org/libsodium/releases/libsodium-1.0.16.tar.gz --output-document=/tmp/libsodium.tar.gz \
    && cd /tmp \
    && tar -xzvf libsodium.tar.gz \
    && cd libsodium-1.0.16 \
    && ./configure \
    && make && make check && make install \
    && rm -rf /tmp/libsodium*

RUN pecl install \
    yaml-2.0.0 \
    imagick \
    libsodium \
    APCu

RUN echo "extension=yaml.so" > /usr/local/etc/php/conf.d/pecl-yaml.ini \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/pecl-imagck.ini \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/pecl-apcu.ini \
    && echo "extension=sodium.so" > /usr/local/etc/php/conf.d/pecl-sodium.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -d memory_limit=-1 -- \
    --install-dir=/usr/local/bin \
    --filename=composer \
    && chmod +x /usr/local/bin/composer

# Remove temporary stuff
RUN apt-get purge -y --auto-remove \
    libicu-dev \
    g++

# Add composer and php scripts for aliases.
COPY home/ /home/php/
RUN chmod +x /home/php/composer.sh \
    && chmod +x /home/php/php.sh \
    && chown php:php /home/php/php.sh /home/php/composer.sh \
    && echo "alias php=/home/php/php.sh" >> /home/php/.bashrc \
    && echo "alias composer=/home/php/composer.sh" >> /home/php/.bashrc

# php.ini
COPY conf.d/php.ini /usr/local/etc/php/conf.d/00-php.ini
COPY conf.d/fpm-pool.conf /usr/local/etc/php-fpm.d/www.conf

# SSMTP config.
COPY conf.d/ssmtp.conf /etc/ssmtp/ssmtp.conf.placeholder
RUN rm -rf /etc/ssmtp/ssmtp.conf \
    && touch /etc/ssmtp/ssmtp.conf \
    && chown php:php /etc/ssmtp/ssmtp.conf \
    && chown php:php /etc/ssmtp/ssmtp.conf.placeholder

# Custom entrypoint
COPY scripts/entrypoint.sh /home/php/entrypoint.sh
RUN chown php:php /home/php/entrypoint.sh \
    && chmod +x /home/php/entrypoint.sh

# Run commands inside this container as the created PHP user.
USER php

WORKDIR /var/www/html

ENTRYPOINT ["/home/php/entrypoint.sh"]
CMD [ "php-fpm" ]