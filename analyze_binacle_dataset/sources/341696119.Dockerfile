FROM bertoost/php:7.2.15-fpm

LABEL maintainer="Bert Oost <hello@bertoost.com>"

USER root

# To build the image, remove custom PHP overrides first
RUN rm -f /usr/local/etc/php/conf.d/01-php-overrides.ini

RUN apt-get update \
    && apt-get install -y \
        nano \
        vim \
        git

# Install xdebug
RUN pecl install xdebug-2.6.1 \
    && docker-php-ext-enable xdebug

# Remove temporary stuff
RUN apt-get purge -y --auto-remove \
        libicu-dev \
        g++ \
    && rm -rf /var/lib/apt/lists/*

# Download and add-in BlackFire
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so

# Copy development php.ini inside the existing image
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/conf.d/00-php.ini

# Xdebug config.
COPY conf.d/pecl-xdebug.ini /usr/local/etc/php/conf.d/pecl-xdebug.ini

# Blackfire integration
COPY conf.d/blackfire.ini /usr/local/etc/php/conf.d/backfire.ini

# Additional php.ini settings for development
COPY conf.d/php-prod.ini /usr/local/etc/php/conf.d/01-php-overrides.ini
COPY conf.d/php-dev.ini /usr/local/etc/php/conf.d/02-php-overrides.ini

# Project binary files
RUN mkdir -p /home/php/projects_bin \
    && chown php:php /home/php/projects_bin
COPY projects_bin/* /home/php/projects_bin/
RUN chown php:php /home/php/projects_bin/*

# Custom entrypoint
COPY scripts/entrypoint.development.sh /home/php/entrypoint.sh
RUN chown php:php /home/php/entrypoint.sh \
    && chmod +x /home/php/entrypoint.sh

USER php

ENV BINARY_DIRECTORY "bin/"

WORKDIR /var/www/html

ENTRYPOINT ["/home/php/entrypoint.sh"]
CMD [ "php-fpm" ]