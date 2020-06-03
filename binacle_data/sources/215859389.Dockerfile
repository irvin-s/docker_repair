FROM php:7.0-apache

# update
RUN apt-get update \
 && apt-get install -y --no-install-recommends sendmail libpng-dev libjpeg-dev libfreetype6-dev imagemagick \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# install php extensions
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install mysqli pdo pdo_mysql hash exif gd \
    && pecl install xdebug\
    && docker-php-ext-enable xdebug

# enable apache mods
RUN a2enmod rewrite && a2enmod headers

# copy config
COPY conf/dev/apache2.conf /etc/apache2/apache2.conf
COPY conf/dev/php.ini  /usr/local/etc/php/php.ini

RUN mkdir /app && chown -R www-data "/app" && chmod -R u+rw "/app"
