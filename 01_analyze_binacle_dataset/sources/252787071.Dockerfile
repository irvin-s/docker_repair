FROM php:7.1-fpm  
  
# Install library dependencies  
RUN apt-get update && apt-get install --no-install-recommends -y \  
libfreetype6-dev \  
libjpeg62-turbo-dev \  
libmcrypt-dev \  
libpng12-dev \  
zlib1g-dev \  
libicu-dev \  
g++ \  
unixodbc-dev \  
libxml2-dev \  
libaio-dev \  
libmemcached-dev \  
freetds-dev \  
libmagickwand-dev \  
imagemagick  
  
# Install Redis and Imagick  
#RUN pecl install redis-3.1.0 \  
# && pecl install imagick-3.4.1 \  
# && docker-php-ext-enable redis imagick  
RUN pecl install redis-3.1.0 \  
&& docker-php-ext-enable redis  
  
# Install APCu and APC backward compatibility  
RUN pecl install apcu \  
&& pecl install apcu_bc-1.0.3 \  
&& docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \  
&& docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini  
  
# Install PHP extensions  
RUN docker-php-ext-install \  
iconv \  
mbstring \  
intl \  
mcrypt \  
pdo \  
pdo_mysql \  
soap \  
sockets \  
zip \  
pcntl  
  
# Clean repository  
#RUN apt-get clean \  
# && rm -rf /var/lib/apt/lists/*  

