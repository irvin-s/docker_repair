######################################################
# 5.5 Apache
######################################################

FROM php:5.5-apache

RUN apt-get update && apt-get install -y \
	libbz2-dev \
	libc-client-dev \
	libcurl4-gnutls-dev \
	libkrb5-dev \
	libmcrypt-dev \
	libpng-dev \
	libreadline-dev \
	libssl-dev \
	libxml2-dev \
	libxslt-dev

######################################################
# Enable / Compile PHP modules
######################################################
RUN docker-php-ext-install -j$(nproc) bcmath
RUN docker-php-ext-install -j$(nproc) calendar
RUN docker-php-ext-install -j$(nproc) ctype
RUN docker-php-ext-install -j$(nproc) curl
RUN docker-php-ext-install -j$(nproc) dba
RUN docker-php-ext-install -j$(nproc) dom
RUN docker-php-ext-install -j$(nproc) exif
RUN docker-php-ext-install -j$(nproc) fileinfo
RUN docker-php-ext-install -j$(nproc) ftp
RUN docker-php-ext-install -j$(nproc) gd
RUN docker-php-ext-install -j$(nproc) gettext
RUN docker-php-ext-install -j$(nproc) hash
RUN docker-php-ext-install -j$(nproc) json
RUN docker-php-ext-install -j$(nproc) mbstring
RUN docker-php-ext-install -j$(nproc) mcrypt
RUN docker-php-ext-install -j$(nproc) mysql
RUN docker-php-ext-install -j$(nproc) opcache
RUN docker-php-ext-install -j$(nproc) pdo
RUN docker-php-ext-install -j$(nproc) pdo_mysql
RUN docker-php-ext-install -j$(nproc) soap
RUN docker-php-ext-install -j$(nproc) sockets
RUN docker-php-ext-install -j$(nproc) xsl
RUN docker-php-ext-install -j$(nproc) zip

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
        && docker-php-ext-install imap
RUN pecl install xdebug-2.5.0

COPY docker-php-ext-opcache.ini /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

######################################################
# Apache modules
######################################################
RUN a2enmod deflate
RUN a2enmod expires
RUN a2enmod file_cache
RUN a2enmod headers
RUN a2enmod rewrite
