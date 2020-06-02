#
# PHP Dockerfile
# 满足laravel5.2版本的基本要求
#
# https://github.com/ibbd/dockerfile-php-fpm
#
# sudo docker build -t ibbd/php-fpm ./
#

# Pull  base image.
FROM php:5.6-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# Install modules
# composer需要先安装zip
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        libmcrypt-dev \
        libssl-dev \
    && apt-get autoremove \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

# install php modules
# pecl install php modules
# 安装mongo扩展时，出现如下错误：
# Unable to load dynamic library '/usr/local/lib/php/extensions/no-debug-non-zts-20131226/mongo.so'
# 需要先安装libssl-dev
# 如果本地构建的话，建议先下载好相应的扩展包
# 直接使用pecl install msgpack会报错：
# Failed to download pecl/msgpack within preferred state "stable", latest release is version 0.5.7, stability "beta", use "channel://pecl.php.net/msgpack-0.5.7" to install
# 注意：msgpack 2.0.0需要php7
    #&& pecl install msgpack-beta \
    #&& pecl install mongo \
    #&& echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
# 2016-05-25 基础镜像与扩展镜像分离
# iconv tokenizer pdo mbstring: 已经包含在基础镜像里
# mysqli, mysql: 都转移到ibbd/php-fpm-ext镜像
# gd库转移到ibbd/php-fpm-ext镜像
# memcache, imagick, mysqli, mysql扩展转移到ibbd/php-fpm-ext库
RUN \
    docker-php-ext-install mcrypt pdo_mysql zip \
    && pecl install redis \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
    && pecl install channel://pecl.php.net/msgpack-0.5.7 \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
    && pecl install mongodb \
    && echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
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
