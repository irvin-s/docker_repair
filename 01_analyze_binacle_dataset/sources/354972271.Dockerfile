#
#########################################
# 这是就架构下的dockerfile
#########################################
#
# PHP Dockerfile
# 满足laravel5.1版本的基本要求，包含了很多杂七杂八的扩展
#
# https://github.com/ibbd/dockerfile-php-fpm
#
# 下载相关资源：./download.sh
# sudo docker build -t ibbd/php-fpm ./
#

# Pull base image.
FROM php:5.6-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# sources.list
# git clone git@github.com:IBBD/docker-compose.git
# 如果导致apt-get Install不成功，可以先注释这句
#ADD ext/sources.list   /etc/apt/sources.list

# Install modules
# composer需要先安装zip
# pecl install imagick时需要libmagickwand-dev。但是这个安装的东西有点多，python2.7也安装了
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        libmcrypt-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libssl-dev \
        libmagickwand-dev \
    && apt-get autoremove \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*


#COPY ext/msgpack.tgz  /msgpack.tgz 
#COPY ext/composer.php /composer.php

# install php modules
# pecl install php modules
# 安装mongo扩展时，出现如下错误：
# Unable to load dynamic library '/usr/local/lib/php/extensions/no-debug-non-zts-20131226/mongo.so'
# 需要先安装libssl-dev
# 如果本地构建的话，建议先下载好相应的扩展包
# 直接使用pecl install msgpack会报错：
# Failed to download pecl/msgpack within preferred state "stable", latest release is version 0.5.7, stability "beta", use "channel://pecl.php.net/msgpack-0.5.7" to install
#
# install imagick 报错如下
# checking ImageMagick MagickWand API configuration program... configure: error: not found. Please provide a path to MagickWand-config or Wand-config program.
# ERROR: `/tmp/pear/temp/imagick/configure --with-php-config=/usr/local/bin/php-config --with-imagick' failed
# 原因：由于安装imagick扩展时需要依赖ImageMagick的函数库，因此必须要先安装ImageMagick, 但是安装了却依然不行。官网上有人评论需要安装libmagickwand-dev
# 解决：apt-get install libmagickwand-dev 
#
# 注意：msgpack 2.0.0需要php7
    #&& pecl install msgpack-beta \
# 2016-03-09 增加mysql扩展
# 2016-07-12 增加soap扩展
RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install  soap \
    && docker-php-ext-install iconv mcrypt pdo_mysql tokenizer mbstring zip mysqli mysql \
    && pecl install redis-2.2.8 \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install memcache \
    && echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
    && pecl install channel://pecl.php.net/msgpack-0.5.7 \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
    && pecl install mongo \
    && echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
    && pecl install imagick-beta \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini \
    && pecl clear-cache

# composer 
# composer中国镜像
# 注意：需要先安装lumen，在安装laravel，否则报错
# 不应在镜像中绑定国内的镜像，因为镜像可能会用到国外的服务器
# 测试国内的容易抽风。。
    #&& curl -sS https://getcomposer.org/installer -o /composer.php \
    #&& php composer.php \
    #&& mv composer.phar /usr/local/bin/composer \
    #&& composer config -g repo.packagist composer http://packagist.phpcomposer.com \
    #&& rm -f composer.php \
    #&& chmod 755 /usr/local/bin/composer \
    #&& php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === 'fd26ce67e3b237fffd5e5544b45b0d92c41a4afe3e3f778e942e43ce6be197b9cdc7c251dcde6e2a52297ea269370680') { echo 'Installer verified';  } else { echo 'Installer corrupt'; unlink('composer-setup.php');  }" \
RUN cd / \
    && php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
    && php composer-setup.php  --filename=composer  --install-dir=/usr/local/bin/ \
    && rm composer-setup.php \
    && composer global require "laravel/lumen-installer" \
    && composer global require "laravel/installer" \
    && composer clearcache \
    && composer clear-cache


# 解决时区问题
ENV TZ "Asia/Shanghai"

# 终端设置
# 执行php-fpm时，默认值是dumb，这时在终端操作时可能会出现：terminal is not fully functional
ENV TERM xterm

# Define mountable directories.
VOLUME /var/www

# 工作目录
WORKDIR /var/www 

EXPOSE 9000
