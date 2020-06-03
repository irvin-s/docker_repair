FROM abiosoft/caddy:builder as caddy-builder  
ARG version="0.10.10"  
RUN VERSION=${version} PLUGINS=cache /bin/sh /usr/bin/builder.sh  
  
FROM composer:1.5 as php-builder  
COPY composer.json composer.lock /src/  
  
WORKDIR /src  
RUN composer install -o \  
\--prefer-dist --no-dev --ignore-platform-reqs \  
\--no-ansi --no-interaction  
  
FROM php:7.1-fpm-alpine  
RUN apk add -u --no-cache $PHPIZE_DEPS \  
&& pecl install apcu \  
&& docker-php-ext-enable apcu \  
&& apk del $PHPIZE_DEPS  
  
COPY \--from=php-builder /src /app  
COPY public /app/public  
  
COPY \--from=caddy-builder /install/caddy /usr/bin/caddy  
COPY Caddyfile /etc/Caddyfile  
  
WORKDIR /app  
  
ENTRYPOINT ["/usr/bin/caddy"]  
CMD ["-conf", "/etc/Caddyfile", "--log", "stdout"]  

