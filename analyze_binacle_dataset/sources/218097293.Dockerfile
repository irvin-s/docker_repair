FROM php:7.0.11-fpm-alpine

# Install tzdata and change to Europe/Paris
RUN  set -x && \
    apk --update add tzdata acl logrotate && \
    ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    date && \
    rm -rf /var/cache/apk/*

# Install tools...
RUN set -x && \
    apk --update add \
      mysql-client \
      sudo \
      bash \
      zlib-dev \
      wget \
      icu \
      icu-libs \
      icu-dev \
      freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
       iconv \
       mcrypt \
       intl \
       pdo \
       pdo_mysql \
       mbstring \
       opcache \
       zip \
       gd \
       exif \
       bz2 \
    && rm -rf /var/cache/apk/*

ARG APCU_VERSION=5.1.5
ARG APCU_BC_VERSION=1.0.3

RUN apk update \
  && apk add --no-cache --virtual .build-php \
    $PHPIZE_DEPS \
  && pecl install apcu-$APCU_VERSION \
  && docker-php-ext-enable apcu \
  && pecl install apcu_bc-$APCU_BC_VERSION \
  && docker-php-ext-enable apc \
  && rm -f /usr/local/etc/php/conf.d/docker-php-ext-apc.ini \
  && rm -f /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini


RUN apk upgrade --update \
	&& apk add --no-cache --virtual \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && sed -i -e "s/zend_extension/#zend_extension/g" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# Custom logrotate configuration for symfony
ADD logrotate/symfony /etc/logrotate.d/symfony
ADD logrotate/cron /etc/periodic/daily/logrotate-cron

# Custom PHP (and apc) configuration
COPY php/*.ini /usr/local/etc/php/conf.d/
COPY php/php.ini /usr/local/etc/php/php.ini

COPY script/start.sh /root/start.sh
COPY script/entry.sh /root/entry.sh
RUN chmod +x /root/start.sh \
  && chmod +x /root/entry.sh \
  && chmod +x /etc/periodic/daily/logrotate-cron

ENTRYPOINT ["/root/entry.sh"]
CMD ["/root/start.sh"]
