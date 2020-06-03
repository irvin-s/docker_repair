FROM php:{{ version }}-apache
MAINTAINER Stepan Mazurov <stepan@socialengine.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
	libmcrypt-dev \
    zlib1g-dev \
    telnet \
    git \
  && rm -rf /var/lib/apt/lists/*

COPY bin/* /usr/local/bin/

# Setup bare-minimum extra extensions for Laravel & others
RUN docker-php-ext-install mbstring mcrypt zip \
	&& docker-php-pecl-install xdebug \
	&& rm ${PHP_INI_DIR}/conf.d/docker-php-pecl-xdebug.ini

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- \
	--install-dir=/usr/local/bin \
	--filename=composer

# You can use this to enable xdebug. start-apache2 script will enable xdebug
# if PHP_XDEBUG is set to 1
ENV PHP_XDEBUG 0
ENV PHP_TIMEZONE "UTC"

# The path that will be used to make Apache run under that user
ENV VOLUME_PATH /app/public

# Setup apache
RUN a2enmod rewrite

# Copy configs
COPY virtual-host.conf /etc/apache2/sites-available/000-default.conf
COPY xdebug.ini ${PHP_INI_DIR}/conf.d/docker-php-pecl-xdebug.ini.disabled
COPY php.ini ${PHP_INI_DIR}/php.ini

# Setup App
RUN mkdir -p /app/public && chown -R www-data:www-data /app

WORKDIR /app

ENTRYPOINT ["setup-container"]

CMD ["apache2-foreground"]
