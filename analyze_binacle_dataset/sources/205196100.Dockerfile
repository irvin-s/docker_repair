FROM php:7.0-fpm

WORKDIR /var/www

# Install System Dependencies
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
        && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y ca-certificates nginx=${NGINX_VERSION} nano wget git \
        && apt-get clean && apt-get purge \
        && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so

# Install PHP extensions
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
        && tar xfz /tmp/redis.tar.gz \
        && rm -r /tmp/redis.tar.gz \
        && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
        && docker-php-ext-install redis pdo_pgsql pgsql soap gd zip mbstring sockets \
        && docker-php-ext-enable redis pdo_pgsql pgsql soap gd zip mbstring sockets \
        && pecl install xdebug && echo ";zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
        && pecl install apcu-4.0.10 && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

# nginx vhost and php ini settings
COPY opt/nginx/prod/default.conf /etc/nginx/conf.d/default.conf
COPY opt/php/prod/conf.d /usr/local/etc/php/conf.d
COPY opt/php/prod/php.ini /usr/local/etc/php/php.ini

ADD . /var/www

RUN php app/console assets:install web  --env=prod --symlink --verbose
RUN chown www-data -R /var/www

# daemon start
EXPOSE 80 443
ENTRYPOINT /usr/local/sbin/php-fpm -D && /usr/sbin/nginx -g 'daemon off;'
