FROM php:7.2-fpm

MAINTAINER Eamon Keane <eamon.keane1@gmail.com>

ARG VCS_REF
ARG BUILD_DATE
ARG PROJECT=laravel5
ARG DOCKERFILE_DIR=docker/php-fpm

# Metadata
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/EamonKeane/laravel5-5-example" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.docker.dockerfile="/docker/php-fpm/Dockerfile"

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    cron \
    procps \
    grep \
    vim \
    supervisor \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    wget \
  && rm -rf /var/lib/apt/lists/*

## Composer Install
RUN EXPECTED_COMPOSER_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '${EXPECTED_COMPOSER_SIGNATURE}') { echo 'Composer.phar Installer verified'; } else { echo 'Composer.phar Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

RUN docker-php-ext-install pdo_pgsql pdo_mysql bcmath opcache \
&& docker-php-ext-configure gd \
  --enable-gd-native-ttf \
  --with-jpeg-dir=/usr/lib \
  --with-freetype-dir=/usr/include/freetype2 && \
  docker-php-ext-install gd bcmath opcache zip

USER root

RUN rm -rf /var/www/* && mkdir -p /var/www/${PROJECT}

COPY composer.json /var/www/${PROJECT}

RUN chown -R www-data:www-data /var/www && usermod -u 1000 www-data

WORKDIR /var/www/${PROJECT}

RUN composer install --no-scripts --no-autoloader

COPY . /var/www/${PROJECT}

RUN composer dump-autoload --optimize;

COPY ${DOCKERFILE_DIR}/entrypoint.sh entrypoint.sh

RUN chmod +x entrypoint.sh

# Create the Laravel Log file and assign it to www-data:
RUN mkdir -p /var/www/${PROJECT}/storage/logs && \
    touch /var/www/${PROJECT}/storage/logs/laravel.log && \
    chown www-data:www-data /var/www/${PROJECT}/storage/logs/laravel.log

#Make storage folder and give access to www-data
RUN mkdir -p /var/www/${PROJECT}/storage && \
    chown -R www-data:www-data /var/www/${PROJECT}/storage

EXPOSE 9000

ENTRYPOINT ["./entrypoint.sh"]

CMD ["php-fpm"]