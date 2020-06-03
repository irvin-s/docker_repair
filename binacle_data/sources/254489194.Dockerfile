FROM php:5.6-fpm

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl git zlib1g-dev && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv
