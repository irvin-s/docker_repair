FROM php:7.2-fpm-alpine  
  
RUN set -x \  
# Install dependencies and PHP extensions.  
&& apk update \  
&& apk add \  
freetype \  
gmp \  
icu-libs \  
libintl \  
libjpeg-turbo \  
libmemcached \  
libpng \  
libsasl \  
libwebp \  
nginx \  
pcre \  
postgresql-libs \  
sqlite-libs \  
tini \  
&& apk add --virtual .build-deps \  
$PHPIZE_DEPS \  
cyrus-sasl-dev \  
freetype-dev \  
gettext-dev \  
gmp-dev \  
icu-dev \  
libjpeg-turbo-dev \  
libmemcached-dev \  
libpng-dev \  
libwebp-dev \  
pcre-dev \  
postgresql-dev \  
sqlite-dev \  
&& docker-php-ext-enable opcache \  
&& docker-php-ext-configure gd \  
\--with-webp-dir=/usr \  
\--with-jpeg-dir=/usr \  
\--with-png-dir=/usr \  
\--with-zlib-dir=/usr \  
\--with-freetype-dir=/usr \  
&& docker-php-ext-configure zip \  
\--with-zlib-dir=/usr \  
&& docker-php-ext-configure pdo_mysql \  
\--with-zlib-dir=/usr \  
&& docker-php-ext-install \  
exif \  
gd \  
gettext \  
gmp \  
intl \  
mbstring \  
pcntl \  
pdo_mysql \  
pdo_pgsql \  
pdo_sqlite \  
zip \  
&& pecl install \  
memcached \  
redis \  
&& docker-php-ext-enable \  
memcached \  
redis \  
# Cleanup.  
&& apk del .build-deps \  
&& rm -r \  
/var/cache/apk/* \  
/tmp/pear \  
# Fix permissions, because we run as www-data.  
&& chmod 755 /var/lib/nginx /var/lib/nginx/tmp/ \  
# Disable PHP-FPM access logging, because nginx already logs for us.  
&& sed -i \  
-e 's/^access\\.log/;access.log/g' \  
/usr/local/etc/php-fpm.d/docker.conf  
  
# Configure PHP.  
COPY php/ /usr/local/etc/php/conf.d/  
# Configure nginx.  
EXPOSE 80  
COPY nginx/ /etc/nginx/  
# Add the entry script, starting nginx and php-fpm.  
# Use tini, so nginx reparents itself to a proper init.  
COPY bin/ /usr/local/bin/  
ENTRYPOINT ["/sbin/tini", "--"]  
CMD ["abc-start"]  
  
# Config and data shared between project versions.  
VOLUME /shared  

