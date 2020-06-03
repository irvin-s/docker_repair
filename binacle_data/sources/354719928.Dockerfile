FROM php:7-apache

COPY config/php.ini /usr/local/etc/php/
COPY app /var/www/html/

RUN a2enmod rewrite
RUN apt-get update
RUN apt-get -qq install \
    libapache2-mod-php5 \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libfreetype6-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mbstring
RUN usermod -u 1000 www-data

WORKDIR /etc/composer

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');";

RUN composer require drupal/console --prefer-dist --optimize-autoloader --sort-packages -vvv
RUN ln -s /etc/composer/vendor/bin/drupal /usr/bin/drupal

WORKDIR /var/www/html/
