FROM phusion/baseimage
MAINTAINER easter1021 <mufasa.hsu@gmail.com>

ENV BUILD_DEPS \
        wget \
        build-essential \
        re2c \
        net-tools \
        git \
        unzip

ENV NGINX_DEPS \
        nginx

ENV PHP70_DEPS \
        php7.0 \
        php7.0-cli \
        php7.0-common \
        php7.0-mysql \
        php7.0-fpm \
        php7.0-dev \
        php7.0-zip \
        php-xdebug \
        php-mcrypt \
        php7.0-soap \
        php7.0-mbstring \
        php7.0-intl \
        php7.0-xml \
        php7.0-curl \
        php7.0-gd \
        php7.0-json

ENV NODEJS_DEPS \
        nodejs \
        npm

# ...put your own build instructions here...
RUN set -xe && \
        LANG=C.UTF-8 add-apt-repository ppa:ondrej/php && \
        apt-get update && apt-get install -y --force-yes --no-install-recommends --no-install-suggests \
            $BUILD_DEPS \
            $NGINX_DEPS \
            $PHP70_DEPS \
            $NODEJS_DEPS \
            supervisor \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# nginx
COPY ./nginx/vhost.conf /etc/nginx/conf.d/vhost.conf
RUN rm -Rf /etc/nginx/sites-enabled/default

# php
RUN /etc/init.d/php7.0-fpm start

# PHP composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
        php -r "if (hash_file('SHA384', 'composer-setup.php') === 'e115a8dc7871f15d853148a7fbac7da27d6c0030b848d9b3dc09e2a0388afed865e6a3d6b3c0fad45c48e2b5fc1196ae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
        php composer-setup.php --install-dir=/usr/bin --filename=composer && \
        php -r "unlink('composer-setup.php');"

# supervisor
COPY ./supervisor/*.conf /etc/supervisor/conf.d/
COPY ./supervisor/run_queue.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_queue.sh

# project source code
COPY ./html /var/www/html
WORKDIR /var/www/html
RUN cp -n .env.example .env
RUN rm -Rf node_modules

# composer install
RUN composer config -g repositories.packagist composer http://packagist.phpcomposer.com
RUN composer install --profile --no-dev --optimize-autoloader
RUN chown -R www-data:www-data .
RUN php artisan key:generate

# start laravel schedule
RUN /bin/bash -c 'crontab -l | { cat; echo "* * * * * php /var/www/html/artisan schedule:run >> /dev/null 2>&1"; } | crontab -'

# 改為台北時區
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && dpkg-reconfigure -fnoninteractive tzdata

EXPOSE 80 433

# Use baseimage-docker's init system.
CMD ["/usr/bin/supervisord"]
