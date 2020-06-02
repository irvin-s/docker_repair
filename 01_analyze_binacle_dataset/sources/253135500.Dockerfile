FROM debian:jessie

ENV ATHENA_PHP_VERSION 5.6
ENV DEBIAN_FRONTEND noninteractive
ENV COMPOSER_ALLOW_SUPERUSER 1

# debian
RUN apt-get update && apt-get install -y curl \
	git \
	parallel \
	apt-transport-https \
	ca-certificates \
	php5 \
	php5-curl \
	php5-apcu \
	php5-xdebug \
	php5-mysql \
	php5-memcache \
	php5-mcrypt

RUN apt-get autoremove && \
  apt-get clean && \
  rm -rf /var/apt/lists/* /var/tmp/* /tmp/*

# get composer
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
RUN chmod +x /usr/local/bin/composer

# prepare
COPY extra-settings.ini /etc/php5/cli/conf.d/100-extra-settings.ini
