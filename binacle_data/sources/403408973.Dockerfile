FROM php:5.6-fpm

RUN apt-get update
RUN apt-get install -y git wget vim

# extensions
# RUN docker-php-ext-install iconv
# RUN docker-php-ext-install mysql
# RUN docker-php-ext-install pdo
# RUN docker-php-ext-install pdo_mysql
# RUN docker-php-ext-install mbstring
# RUN docker-php-ext-install opcache
# RUN docker-php-ext-install bcmath
# RUN docker-php-ext-install pcntl
RUN apt-get install zlib1g-dev -y && docker-php-ext-install zip
# RUN apt-get install libxml2-dev -y && docker-php-ext-install soap
# RUN apt-get install libmcrypt-dev -y && docker-php-ext-install mcrypt
# RUN apt-get install libpng12-dev -y && docker-php-ext-install gd
# RUN apt-get install libxml2-dev -y && docker-php-ext-install xml
# RUN apt-get install libicu-dev -y && docker-php-ext-install intl
# RUN apt-get install -y libmemcached-dev zlib1g-dev && pecl install memcached-2.2.0 && docker-php-ext-enable memcached
# RUN apt-get install -y zlib1g-dev && pecl install memcache && docker-php-ext-enable memcache
# RUN apt-get install pkg-config libssl-dev -y && pecl install mongo && docker-php-ext-enable mongo
# RUN apt-get install -y libmagickwand-dev && pecl install imagick  && docker-php-ext-enable imagick

# xdebug
RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

# php.ini
COPY php.ini /usr/local/etc/php/

# www.conf
COPY www.conf /usr/local/etc/php-fpm.d/

# install composer
COPY install-composer.sh /tmp/install-composer.sh
RUN chmod +x /tmp/install-composer.sh
RUN bash /tmp/install-composer.sh
VOLUME /root/.composer
