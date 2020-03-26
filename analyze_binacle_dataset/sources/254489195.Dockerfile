FROM php:7.0-fpm

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl git zlib1g-dev && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install zip && \
    # echo "/usr/local/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    # echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    # echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv
