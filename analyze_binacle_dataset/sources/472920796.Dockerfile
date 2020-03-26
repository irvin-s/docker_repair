FROM php:7.3-fpm-stretch

# Install PHP extensions
RUN apt-get update && apt-get install -y \
      libpq-dev \
      libicu-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-install \
      pdo_pgsql \
      pgsql \
      intl \
      opcache
