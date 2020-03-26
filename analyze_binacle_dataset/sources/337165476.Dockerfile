# adapted from https://github.com/bobbymaher/docker-laravel-workers

FROM php:7.1-fpm

# install php extensions laravel needs
RUN apt-get update && \
    docker-php-ext-install pdo_mysql && \
    apt-get install -y curl git zlib1g-dev supervisor && \
    docker-php-ext-install zip

# install grpc extension for php
RUN pecl install grpc\
    && docker-php-ext-enable grpc 
    
COPY supervisord.conf /etc/supervisord.conf
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisord.conf"]

