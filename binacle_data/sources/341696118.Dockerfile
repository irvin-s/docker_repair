FROM php:7.2.15-fpm-stretch

LABEL maintainer="Bert Oost <hello@bertoost.com>"

USER root

# Create docker PHP user.
RUN adduser \
   -u 1000 \
   --system \
   --shell /bin/bash \
   --group \
   --disabled-password \
   php

# Install modules
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        build-essential \
        libfreetype6-dev \
        libicu-dev \
        libjpeg62-turbo-dev \
        libmagickwand-6.q16-dev \
        libmcrypt-dev \
        libssl-dev \
        libyaml-dev \
        imagemagick \
        locales \
        re2c \
        unzip \
        g++ \
        zip \
        ssmtp \
        gettext \
        openssh-client \
        pdftk \
        apt-transport-https \
        mysql-client \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
        iconv \
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

RUN pecl install \
    yaml-2.0.0 \
    imagick \
    APCu

# Remove temporary stuff
RUN apt-get purge -y --auto-remove \
    libicu-dev \
    g++

# create the default running directory
RUN mkdir -p /var/www/html \
    && chown php:php /var/www/html

# Create the config ini files
RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/conf.d/00-php.ini \
    && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/pecl-yaml.ini \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/pecl-imagck.ini \
    && echo "extension=apcu.so" > /usr/local/etc/php/conf.d/pecl-apcu.ini

COPY conf.d/php-prod.ini /usr/local/etc/php/conf.d/01-php-overrides.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -d memory_limit=-1 -- \
    --install-dir=/usr/local/bin \
    --filename=composer \
    && chmod +x /usr/local/bin/composer

# Add composer and php scripts for aliases.
COPY home/ /home/php/
RUN chmod +x /home/php/composer.sh \
    && chmod +x /home/php/php.sh \
    && chown php:php /home/php/php.sh /home/php/composer.sh \
    && echo "alias php=/home/php/php.sh" >> /home/php/.bashrc \
    && echo "alias composer=/home/php/composer.sh" >> /home/php/.bashrc

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

ENV PHP_DATE_TIMEZONE=Europe/Amsterdam
ENV PHP_MAX_EXECUTION_TIME=60
ENV PHP_MEMORY_LIMIT=256M
ENV PHP_POST_MAX_SIZE=128M
ENV PHP_UPLOAD_MAX_FILESIZE=128M

WORKDIR /var/www/html

ENTRYPOINT ["/home/php/entrypoint.sh"]
CMD ["php-fpm"]
