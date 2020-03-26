# Pull base image
FROM daocloud.io/library/centos:latest
MAINTAINER Cdoco <ocdoco@gmail.com>

ENV PHP_VERSION 7.0.14

# Update source
RUN set -x \
    && yum update -y \
    && yum install -y wget gcc gcc-c++ make perl tar libjpeg libpng libjpeg-devel libpng-devel libjpeg-turbo freetype freetype-devel \
        libcurl-devel libxml2-devel libjpeg-turbo-devel libXpm-devel libXpm libicu-devel libmcrypt libmcrypt-devel libxslt-devel libxslt openssl openssl-devel bzip2-devel \
    && yum clean all \
    && mkdir -p /data/deps \
    && mkdir -p /data/server \

# Install zlib
    && cd /data/deps \
    && wget http://jaist.dl.sourceforge.net/project/libpng/zlib/1.2.8/zlib-1.2.8.tar.gz \
    && tar zxvf zlib-1.2.8.tar.gz \
    && cd zlib-1.2.8 \
    && ./configure --static --prefix=/data/server/libs/zlib \
    && make \
    && make install \

# Install openssl
    && cd /data/deps \
    && wget http://www.openssl.org/source/openssl-0.9.8zb.tar.gz \
    && tar zxvf openssl-0.9.8zb.tar.gz \
    && cd openssl-0.9.8zb \
    && ./config --prefix=/data/server/libs/openssl -L/data/server/libs/zlib/lib -I/data/server/libs/zlib/include threads zlib enable-static-engine\
    && make \
    && make install \

# Install pcre
    && cd /data/deps \
    && wget http://jaist.dl.sourceforge.net/project/pcre/pcre/8.33/pcre-8.33.tar.gz \
    && tar zxvf pcre-8.33.tar.gz \
    && cd pcre-8.33 \
    && ./configure --prefix=/data/server/libs/pcre \
    && make \
    && make install \

# Install nginx
    && cd /data/deps \
    && wget http://nginx.org/download/nginx-1.9.9.tar.gz \
    && tar zxvf nginx-1.9.9.tar.gz \
    && cd nginx-1.9.9 \
    && './configure' \
       '--prefix=/data/server/nginx' \
       '--with-debug' \
       '--with-openssl=/data/deps/openssl-0.9.8zb' \
       '--with-zlib=/data/deps/zlib-1.2.8' \
       '--with-pcre=/data/deps/pcre-8.33' \
       '--with-http_stub_status_module' \
       '--with-http_gzip_static_module' \
    && make \
    && make install \

# Install libmcrypt
    && cd /data/deps \
    && wget ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.6.tar.gz \
    && tar zxvf libmcrypt-2.5.6.tar.gz \
    && cd libmcrypt-2.5.6 \
    && ./configure \
    && make \
    && make install \

# Install php
    && cd /data/deps \
    && wget http://cn2.php.net/distributions/php-$PHP_VERSION.tar.gz \
    && tar zxvf php-$PHP_VERSION.tar.gz \
    && cd php-$PHP_VERSION \
    && './configure' \
       '--prefix=/data/server/php/' \
       '--with-config-file-path=/data/server/php/etc/' \
       '--with-config-file-scan-dir=/data/server/php/conf.d/' \
       '--enable-fpm' \
       '--enable-cgi' \
       '--disable-phpdbg' \
       '--enable-mbstring' \
       '--enable-calendar' \
       '--with-xsl' \
       '--with-openssl' \
       '--enable-soap' \
       '--enable-zip' \
       '--enable-shmop' \
       '--enable-sockets' \
       '--with-gd' \
       '--with-jpeg-dir' \
       '--with-png-dir' \
       '--with-xpm-dir' \
       '--with-xmlrpc' \
       '--enable-pcntl' \
       '--enable-intl' \
       '--with-mcrypt' \
       '--enable-sysvsem' \
       '--enable-sysvshm' \
       '--enable-sysvmsg' \
       '--enable-opcache' \
       '--with-iconv' \
       '--with-bz2' \
       '--with-curl' \
       '--enable-mysqlnd' \
       '--with-mysqli=mysqlnd' \
       '--with-pdo-mysql=mysqlnd' \
       '--with-zlib' \
       '--with-gettext=' \
    && make \
    && make install \

# delete data dir
    && yum remove -y gcc* make* \
    && rm -rf /data/deps \

# cp php conf
ADD files/php/php.ini /data/server/php/etc/php.ini
ADD files/php/php-fpm.conf /data/server/php/etc/php-fpm.conf
ADD files/php/www.conf /data/server/php/etc/php-fpm.d/www.conf

# add nginx conf
ADD files/nginx/nginx.conf /data/server/nginx/conf/nginx.conf
ADD files/nginx/default.conf /data/server/nginx/conf/vhost/default.conf
RUN set -x \
    && mkdir -p /data/logs/nginx \
    && touch /data/logs/nginx/access.log

# add run.sh
ADD files/run.sh /data/run.sh
RUN set -x \
    && chmod u+x /data/run.sh

RUN set -x \
    && mkdir -p /data/www \
    && echo "<?php phpinfo();?>" > /data/www/index.php

# Start php-fpm And nginx
CMD ["/data/run.sh"]

EXPOSE 80
