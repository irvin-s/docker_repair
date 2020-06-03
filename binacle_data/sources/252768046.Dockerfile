FROM php:7.1-fpm  
  
MAINTAINER Adam Paterson <hello@adampaterson.co.uk>  
  
# Install dependencies  
RUN apt-get update \  
&& apt-get install -y \  
libfreetype6-dev \  
libjpeg62-turbo-dev \  
libmcrypt-dev \  
libpng12-dev \  
libicu-dev \  
libicu52  
  
# Configure gd library  
RUN docker-php-ext-configure \  
gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/  
  
# Install required PHP extensions  
RUN docker-php-ext-install \  
iconv \  
exif \  
mbstring \  
pdo_mysql \  
pdo \  
intl \  
opcache \  
gd \  
zip  
  
# Install the 2.4 version of xdebug compatible with PHP 7.0  
RUN pecl install -o -f xdebug-2.4.0  
  
VOLUME /root/.composer/cache  
  
ADD bin/docker-environment /usr/local/bin/  
ADD etc/php.ini /usr/local/etc/php/conf.d/zz-sylius.ini  
ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini  
ADD etc/php-fpm.conf /usr/local/etc/  
  
ENV PHP_MEMORY_LIMIT 2G  
ENV PHP_ENABLE_XDEBUG FALSE  
ENV SYLIUS_ROOT /var/www/sylius  
ENV DEBUG false  
  
ENTRYPOINT ["/usr/local/bin/docker-environment"]  
CMD ["php-fpm", "-F"]  

