FROM php:7.1-fpm-stretch
LABEL maintainer="boitata@leroymerlin.com.br"

# libssl-dev: required by mongodb
# zlib1g-dev: required by zip
# libcap2-bin: required by setcap
RUN apt-get update -qq \
  && apt-get install -qq --no-install-recommends \
    git \
    nginx \
    nginx-extras \
    supervisor \
    zip \
    unzip \
    libssl-dev \
    zlib1g-dev \
    libcap2-bin \
 && apt-get clean

RUN pecl install mongodb \
  && docker-php-ext-enable \
    mongodb \
  && docker-php-ext-install \
    pcntl \
    zip

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN sed -ri -e 's!/run/nginx.pid!/var/run/nginx/nginx.pid!g' /etc/nginx/nginx.conf \
  && sed -ri -e 's!user www-data;!daemon off;!g' /etc/nginx/nginx.conf \
  && sed -ri -e 's!# server_tokens off;!more_clear_headers Server;!g' /etc/nginx/nginx.conf

RUN sed -ri -e 's!user = www-data!; user = www-data!g' /usr/local/etc/php-fpm.d/www.conf \
  && sed -ri -e 's!group = www-data!; group = www-data!g' /usr/local/etc/php-fpm.d/www.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
  && ln -sf /dev/stderr /var/log/nginx/error.log

ARG UID=1000
ARG GID=1000

RUN groupmod -g ${GID} www-data \
  && usermod -u ${UID} -g www-data www-data \
  && mkdir -p /var/www/html \
    /var/run/nginx \
    /var/run/supervisor \
    /var/log/supervisor \
  && chown -hR www-data:www-data \
    /var/www \
    /usr/local/ \
    /etc/nginx/ \
    /var/lib/nginx/ \
    /var/log/nginx/ \
    /var/run/nginx \
    /var/run/supervisor \
    /var/log/supervisor \
  && setcap 'cap_net_bind_service=+ep' /usr/sbin/nginx

COPY default.conf /etc/nginx/sites-enabled/default
COPY supervisord.conf /etc/supervisor/supervisord.conf

USER www-data:www-data
WORKDIR /var/www/html
ENV PATH=$PATH:/var/www/.composer/vendor/bin

EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["/usr/bin/supervisord"]
