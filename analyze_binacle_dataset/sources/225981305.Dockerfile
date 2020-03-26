FROM php:7-cli
MAINTAINER XiaodongHuang <ddonng@qq.com>

RUN apt-get update && apt-get install -y git zlib1g-dev
# install pdo_mysql extension
RUN docker-php-ext-install pdo_mysql

# memcached extensions
RUN apt-get install -y libmemcached11 libmemcachedutil2 build-essential libmemcached-dev libz-dev
RUN git clone -b php7 https://github.com/php-memcached-dev/php-memcached.git
RUN cd php-memcached && phpize && ./configure && make && make install \
    && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini

# install phpredis extension
ENV PHPREDIS_VERSION 3.0.0
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis

# install mongo extension, phalcon3.0 is still not support mongoDB driver T.T
#RUN apt-get -y install libssl-dev pkg-config && pecl install mongo \
#    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini

# swoole extension，use 1.8.7
RUN pecl install swoole-1.8.7 && echo extension=swoole.so >> /usr/local/etc/php/conf.d/swoole.ini

# phalcon extension
RUN apt-get install -y libpcre3-dev openssl libssl-dev
RUN git clone --depth=1 http://github.com/phalcon/cphalcon
RUN cd cphalcon/build && ./install \
    && echo extension=phalcon.so >> /usr/local/etc/php/conf.d/phalcon.ini
RUN rm -rf cphalcon

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd
# clean
RUN apt-get remove -y build-essential libmemcached-dev libz-dev git \
    && apt-get autoremove -y

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /home/www/
VOLUME ["/home/www/"]
