FROM php:7.0.13-fpm

# Install modules
RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    echo "deb http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >/etc/apt/sources.list && \
    echo "deb http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ jessie main non-free contrib" >>/etc/apt/sources.list && \
    echo "deb-src http://mirrors.aliyun.com/debian/ jessie-proposed-updates main non-free contrib" >>/etc/apt/sources.list

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libicu-dev \
                --no-install-recommends

RUN docker-php-ext-install mcrypt opcache intl mysqli  mbstring pdo_mysql exif \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd


RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./php.ini /usr/local/etc/php/
COPY ./www.conf /usr/local/etc/php/

RUN apt-get purge -y g++ \
    && apt-get autoremove -y \
    && rm -r /var/lib/apt/lists/* \
    && rm -rf /tmp/*

RUN usermod -u 1000 www-data

EXPOSE 9000
CMD ["php-fpm"]
