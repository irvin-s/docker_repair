FROM php:5.6-fpm

LABEL maintainer="hello@withknown.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends mysql-client \
 && savedAptMark="$(apt-mark showmanual)" \
 && apt-get install -y --no-install-recommends \
      libfreetype6-dev \
      libicu-dev \
      libjpeg-dev \
      libmcrypt-dev \
      libpng-dev \
      libxml2-dev \
 && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
 && docker-php-ext-install exif gd intl mcrypt opcache pdo_mysql zip json xmlrpc \
# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
 && apt-mark auto '.*' > /dev/null \
 && apt-mark manual $savedAptMark \
 && ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
    | awk '/=>/ { print $3 }' \
    | sort -u \
    | xargs -r dpkg-query -S \
    | cut -d: -f1 \
    | sort -u \
    | xargs -rt apt-mark manual \
 && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
 && rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
  echo 'opcache.memory_consumption=128'; \
  echo 'opcache.interned_strings_buffer=8'; \
  echo 'opcache.max_accelerated_files=4000'; \
  echo 'opcache.revalidate_freq=60'; \
  echo 'opcache.fast_shutdown=1'; \
  echo 'opcache.enable_cli=1'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# PECL extensions
RUN pecl install APCu-4.0.11 \
 && docker-php-ext-enable apcu

ENV KNOWN_VERSION 0.9.9
VOLUME /var/www/html

RUN fetchDeps=" \
    gnupg \
    dirmngr \
  " \
 && apt-get update \
 && apt-get install -y --no-install-recommends $fetchDeps \
 && curl -o known.tgz -fSL http://assets.withknown.com/releases/known-${KNOWN_VERSION}.tgz \
 && curl -o known.tgz.sig -fSL http://assets.withknown.com/releases/known-${KNOWN_VERSION}.tgz.sig \
 && export GNUPGHOME="$(mktemp -d)" \
#gpg key from hello@withknown.com
 && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "53DE 5B99 2244 9132 8B92 7516 052D B5AC 742E 3B47" \
 && gpg --batch --verify known.tgz.sig known.tgz \
 && mkdir /usr/src/known \
 && tar -xf known.tgz -C /usr/src/known \
 && rm -r "$GNUPGHOME" known.tgz* \
 && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $fetchDeps \
 && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
