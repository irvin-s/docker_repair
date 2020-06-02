FROM php:7.2

# APT packages
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

# APCU extension
RUN pecl install apcu \
    && docker-php-ext-enable apcu \
    && rm -rf /tmp/pear

## PHP configuration
COPY config/php.ini /usr/local/etc/php/php.ini

# Composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin

# Bash
RUN chsh -s /bin/bash www-data

# Workdir
WORKDIR /var/www/html

# Entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
