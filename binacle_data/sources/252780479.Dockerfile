FROM php:7.0-alpine  
  
MAINTAINER Spencer Rinehart <anubis@overthemonkey.com>  
  
ENV COMPOSER_HOME /.composer  
ENV PATH /code/bin:$COMPOSER_HOME/vendor/bin:$PATH  
  
RUN addgroup alpine && adduser -G alpine -s /bin/sh -D alpine && \  
apk add --update --virtual composer-deps autoconf alpine-sdk && \  
pecl install xdebug && \  
docker-php-ext-enable xdebug && \  
docker-php-ext-install mbstring && \  
apk del composer-deps && \  
rm -rf /apk /tmp/* /var/cache/apk/* && \  
mkdir /code && \  
chown alpine:alpine /code && \  
mkdir -p $COMPOSER_HOME/cache && \  
chmod 777 $COMPOSER_HOME/cache && \  
mkdir -p $COMPOSER_HOME/vendor/bin && \  
curl -sSL https://getcomposer.org/installer | \  
php -- --install-dir=$COMPOSER_HOME/vendor/bin --filename=composer  
  
USER alpine  
WORKDIR /code  
  
VOLUME /.composer/cache  
  
CMD ["echo", "Please specify a command to run, e.g. composer install"]  

