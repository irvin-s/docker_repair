FROM php:7.1-fpm

RUN apt-get update && buildDeps="libpq-dev libzip-dev" && apt-get install -y $buildDeps git  nano wget --no-install-recommends
RUN docker-php-ext-install pdo pdo_pgsql pdo_mysql pgsql zip bcmath

RUN wget https://getcomposer.org/composer.phar && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

RUN pecl install -o -f redis && \
    pecl install xdebug-2.5.0 && \
    docker-php-ext-enable redis xdebug && \
    rm -rf /tmp/pear

COPY php-custom.ini /usr/local/etc/php/conf.d/php-custom.ini

RUN mkdir -p /usr/src/custom-installers/ && \
    curl -SL http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz \
    | tar -xJC /usr/src/custom-installers/ && \
    cd /usr/src/custom-installers/wkhtmltox/bin && \
    cp wkhtmltopdf  /usr/local/bin/wkhtmltopdf && \
    cp wkhtmltoimage  /usr/local/bin/wkhtmltoimage && \
    apt-get install -y libxrender1 libxext6 libfontconfig

WORKDIR /app
