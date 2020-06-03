FROM php:fpm-alpine  
  
ENV APP_ENV prod  
  
COPY ./php.ini-${APP_ENV} /usr/local/etc/php/php.ini  
  
# Install opcache  
RUN docker-php-ext-install opcache  
  
# Install APCu  
RUN apk update \  
&& apk add --no-cache --virtual .build-php \  
$PHPIZE_DEPS \  
&& pecl install apcu \  
&& docker-php-ext-enable apcu \  
&& pecl install apcu_bc-1.0.3 \  
&& docker-php-ext-enable apc \  
&& docker-php-ext-install \  
mcrypt \  
intl \  
pdo \  
pdo_mysql  
  
CMD ["php-fpm"]

