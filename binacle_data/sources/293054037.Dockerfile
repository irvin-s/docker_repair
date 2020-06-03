FROM php:5.5-fpm

RUN mkdir /root/.ssh
RUN ln -s /code/docker_confs/id_rsa /root/.ssh/id_rsa

RUN apt-get -y update && apt-get -y install libssl-dev git unzip vim libpq-dev

RUN docker-php-ext-install pdo pdo_mysql

RUN pecl install xdebug-2.2.7 \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_port=9000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_host=172.17.0.1" >> /usr/local/etc/php/conf.d/xdebug.ini

ENV TERM xterm-256color

WORKDIR /code