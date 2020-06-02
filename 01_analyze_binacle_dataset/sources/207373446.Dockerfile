FROM php:7-fpm

RUN apt-get update \
    && apt-get install -y wget software-properties-common python-software-properties \
    && echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list \
    && wget https://www.dotdeb.org/dotdeb.gpg \
    && apt-key add dotdeb.gpg \
    && apt-get update && apt-get install -y \
        php7.0-common \
        php7.0-cli \
        php7.0-curl \
        php7.0-gd \
        php7.0-imagick \
        php7.0-intl \
        php7.0-json \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-opcache \
    && docker-php-ext-install mysqli pdo_mysql \
    && rm -rf /var/lib/apt

ADD php.ini /usr/local/etc/php/
ADD example.pool.conf /etc/php5/fpm/pool.d/

ARG UID=1000
RUN usermod -u ${UID} www-data

CMD ["php-fpm", "-F"]

EXPOSE 9000
