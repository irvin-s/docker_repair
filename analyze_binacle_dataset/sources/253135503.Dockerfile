FROM php:7.0-cli-jessie
ENV ATHENA_PHP_VERSION 7.0

# Packages
RUN apt-get update && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y \
      libicu-dev \
      libpq-dev \
      libmcrypt-dev \
      mysql-client \
      libmysqlclient-dev \
      curl \
      git \
      unzip \
      wget \
      parallel \
    && docker-php-ext-install \
      intl \
      mcrypt \
      pcntl \
      zip \
      opcache \
    && apt-get autoremove && apt-get clean && rm -r /var/lib/apt/lists/*

# Time Zone
RUN echo "date.timezone=${PHP_TIMEZONE:-UTC}" > $PHP_INI_DIR/conf.d/date_timezone.ini

# Disable Populating Raw POST Data
# Not needed when moving to PHP 7.
# http://php.net/manual/en/ini.core.php#ini.always-populate-raw-post-data
RUN echo "always_populate_raw_post_data=-1" > $PHP_INI_DIR/conf.d/always_populate_raw_post_data.ini

# Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# Add global binary directory to PATH and make sure to re-export it
ENV PATH /composer/vendor/bin:$PATH

# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer && rm -rf /tmp/composer-setup.php

# Setup XDebug
RUN curl -fsSL 'https://pecl.php.net/get/xdebug-2.4.0.tgz' -o xdebug.tar.gz \
    && mkdir -p xdebug \
    && tar -xf xdebug.tar.gz -C xdebug --strip-components=1 \
    && rm xdebug.tar.gz \
    && ( \
    cd xdebug \
    && phpize \
    && ./configure --enable-xdebug \
    && make -j$(nproc) \
    && make install \
    ) \
    && rm -r xdebug \
    && docker-php-ext-enable xdebug

COPY extra-settings.ini /etc/php5/cli/conf.d/100-extra-settings.ini
COPY docker-php-ext-disable /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-php-ext-disable
