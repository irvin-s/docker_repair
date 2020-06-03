FROM gabesullice/drocker-php-fpm

RUN apk --update add vim bash

# Install composer
ADD https://getcomposer.org/installer /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --filename=composer --install-dir=/usr/local/bin \
    && rm /tmp/composer-setup.php

VOLUME /var/www/web

WORKDIR /var/www/web
