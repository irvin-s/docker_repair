# Base image, official docker PHP image
FROM php:7.0-fpm

############################################################################
#### This installes following extensions:                               ####
############################################################################
#### - pgsql                                                            ####
#### - iconv                                                            ####
#### - intl                                                             ####
#### - redis                                                            ####
#### - apcu                                                             ####
#### - apc-bc                                                           ####
#### - sockets                                                          ####
#### - memcached                                                        ####
#### - imagick                                                          ####
############################################################################

# default PHP config
RUN if [ -f /usr/local/etc/php/php.ini ]; then rm /usr/local/etc/php/php.ini; fi
COPY ["config/php.ini", "/usr/local/etc/php/"]

# Install dependencies
RUN apt-get update\
  && apt-get install -my --no-install-recommends\
  # intl dependencies
  zlib1g-dev libicu-dev g++\
  # mcrypt dependencies
  libmcrypt-dev\
  # Postgres
  libpq-dev\
  # SQLite
  #libsqlite3-dev\
  # ImageMagick
  libmagickwand-dev\
  imagemagick\
  # Memcached
  libmemcached-dev\
  # Event
  libevent-dev\
  openssl


# Install basic extensions
RUN docker-php-ext-install sockets mcrypt iconv

# Install intl extensions
RUN docker-php-ext-configure intl\
  && docker-php-ext-install intl

# Install postgres extension
RUN docker-php-ext-configure pdo_pgsql\
  && docker-php-ext-install pdo_pgsql

# Install event extension
ADD https://pecl.php.net/get/event-2.0.3.tgz /tmp/event.tar.gz
RUN mkdir -p /usr/src/php/ext/event\
  && tar xf /tmp/event.tar.gz -C /usr/src/php/ext/event --strip-components=1

RUN rm -rd /usr/src/php/ext/event && rm /tmp/event.tar.gz

# Install redis extension
ADD https://github.com/phpredis/phpredis/archive/php7.tar.gz /tmp/phpredis.tar.gz
RUN mkdir -p /usr/src/php/ext/redis\
  && tar xf /tmp/phpredis.tar.gz -C /usr/src/php/ext/redis --strip-components=1

# configure and install
RUN docker-php-ext-configure redis\
  && docker-php-ext-install redis
# cleanup
RUN rm -rd /usr/src/php/ext/redis && rm /tmp/phpredis.tar.gz

# Install imagick extension
ADD https://github.com/mkoppanen/imagick/archive/phpseven.tar.gz /tmp/phpimagick.tar.gz
RUN mkdir -p /usr/src/php/ext/imagick\
  && tar xf /tmp/phpimagick.tar.gz -C /usr/src/php/ext/imagick --strip-components=1

# configure and install
RUN docker-php-ext-configure imagick\
  && docker-php-ext-install imagick
# cleanup
RUN rm -rd /usr/src/php/ext/imagick && rm /tmp/phpimagick.tar.gz

# Install memcached extension

ADD https://github.com/php-memcached-dev/php-memcached/archive/php7.tar.gz /tmp/phpmemcached.tar.gz
RUN mkdir -p /usr/src/php/ext/memcached\
  && tar xf /tmp/phpmemcached.tar.gz -C /usr/src/php/ext/memcached --strip-components=1

# configure and install
RUN docker-php-ext-configure memcached\
  && docker-php-ext-install memcached

# cleanup
RUN rm -rd /usr/src/php/ext/memcached && rm /tmp/phpmemcached.tar.gz

# Install APCu extension
ADD https://pecl.php.net/get/apcu-5.1.3.tgz /tmp/apcu.tar.gz
RUN mkdir -p /usr/src/php/ext/apcu\
  && tar xf /tmp/apcu.tar.gz -C /usr/src/php/ext/apcu --strip-components=1

# configure and install
RUN docker-php-ext-configure apcu\
  && docker-php-ext-install apcu

RUN rm -rd /usr/src/php/ext/apcu && rm /tmp/apcu.tar.gz

# Install APCu-BC extension
ADD https://pecl.php.net/get/apcu_bc-1.0.3.tgz /tmp/apcu_bc.tar.gz
RUN mkdir -p /usr/src/php/ext/apcu-bc\
  && tar xf /tmp/apcu_bc.tar.gz -C /usr/src/php/ext/apcu-bc --strip-components=1

# configure and install
RUN docker-php-ext-configure apcu-bc\
  && docker-php-ext-install apcu-bc

RUN rm -rd /usr/src/php/ext/apcu-bc && rm /tmp/apcu_bc.tar.gz

#Load APCU.ini before APC.ini
RUN rm /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini
RUN echo extension=apcu.so > /usr/local/etc/php/conf.d/20-php-ext-apcu.ini

RUN rm /usr/local/etc/php/conf.d/docker-php-ext-apc.ini
RUN echo extension=apc.so > /usr/local/etc/php/conf.d/21-php-ext-apc.ini

VOLUME ["/usr/local/etc"]

RUN usermod -u 1000 www-data

EXPOSE 9000
