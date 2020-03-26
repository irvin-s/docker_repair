FROM php:5.4-cli

RUN apt-get update && apt-get install -y \
       libmcrypt-dev \
       libpq-dev \
       git \
       subversion

RUN docker-php-ext-install iconv mcrypt zip bcmath

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

WORKDIR /var/www/html
