FROM php:7.1-apache-stretch
LABEL maintainer="boitata@leroymerlin.com.br"

# libssl-dev: required by mongodb
# zlib1g-dev: required by zip
# libcap2-bin: required by setcap
RUN apt-get update -qq \
  && apt-get install -qq --no-install-recommends \
    git \
    zip \
    unzip \
    libssl-dev \
    zlib1g-dev \
    libcap2-bin \
  && apt-get clean

RUN pecl install mongodb \
  && docker-php-ext-enable \
    mongodb \
  && docker-php-ext-install \
    pcntl \
    zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Apache configuration
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
  && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
  && a2enmod rewrite

ARG UID=1000
ARG GID=1000

RUN groupmod -g ${GID} www-data \
  && usermod -u ${UID} -g www-data www-data \
  && chown -hR www-data:www-data \
    /var/www \
    /usr/local/ \
    /etc/ssl/ \
    /etc/apache2/ \
    /var/lock/apache2/ \
    /var/run/apache2/ \
    /var/log/apache2/ \
  && setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2

EXPOSE 80
# /Apache configuration

USER www-data:www-data
WORKDIR /var/www/html
ENV PATH=$PATH:/var/www/.composer/vendor/bin
