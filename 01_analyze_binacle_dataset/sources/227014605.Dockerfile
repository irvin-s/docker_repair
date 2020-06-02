FROM daocloud.io/php:5.6-apache
RUN apt-get update \
    && apt-get install -y \
        libz-dev \
        git \
    && docker-php-ext-install \
        sockets \
        zip \

    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

    && curl -sS https://getcomposer.org/installer \
        | php -- --install-dir=/usr/local/bin --filename=composer
RUN a2enmod rewrite \
    && mkdir -p /app \
    && rm -fr /var/www/html \
    && ln -s /app/public /var/www/html
WORKDIR /app
COPY ./composer.json /app/
COPY ./composer.lock /app/
RUN composer install  --no-autoloader --no-scripts
COPY . /app
RUN composer install \
    && chown -R www-data:www-data /app \
    && chmod -R 0777 /app/storage
