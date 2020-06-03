FROM php:7.2-fpm

RUN apt-get update -qq && apt-get install -qqy \
    sudo \
    wget \
    git \
    apt-utils \
    acl \
    openssl \
    nano \
    htop \
    unzip \
    tzdata \
    netcat \
    iproute2 \
    cron \
    libicu-dev \
    libmcrypt-dev \
    libfreetype6-dev libjpeg-dev \
    apt-transport-https lsb-release ca-certificates \
    software-properties-common \
    libbz2-dev \
    && echo "Europe/Paris" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata \
    && echo 'alias ll="ls -lah --color=auto"' >> /etc/bash.bashrc \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
       iconv \
       intl \
       pdo \
       pdo_mysql \
       mbstring \
       opcache \
       zip \
       gd \
       exif \
       bz2 \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && find / -user 33 -exec chown -h 1000 {} \; || true \
    && find / -group 33 -exec chgrp -h 1000 {} \; || true \
    && usermod -g 1000 www-data

# Custom logrotate configuration for symfony
ADD logrotate/symfony /etc/logrotate.d/symfony
ADD logrotate/php /etc/logrotate.d/php
ADD logrotate/cron /etc/periodic/daily/logrotate-cron

# Custom PHP (and apc) configuration
COPY php/*.ini /usr/local/etc/php/conf.d/
COPY php/php.ini /usr/local/etc/php/php.ini

COPY script/start.sh /root/start.sh
COPY script/entry.sh /root/entry.sh

# Make sure every user can start the container
RUN chmod +x /root/start.sh /root/entry.sh \
  && chmod +x /etc/periodic/daily/logrotate-cron

WORKDIR /var/www/html

ENTRYPOINT ["/root/entry.sh"]
CMD ["/root/start.sh"]
