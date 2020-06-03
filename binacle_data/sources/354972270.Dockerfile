# 在官方的镜像上增加简单
FROM php:7.3.2-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# 安装扩展
# https://github.com/docker-library/php/issues/662
RUN apt-get update \
&& apt-get install -y --no-install-recommends \
    libzip4 \
    libzip-dev \
    unzip \
    libmcrypt-dev \
    libssl-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
&& apt-get autoremove \
&& apt-get clean \
&& rm -r /var/lib/apt/lists/* \
&& cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 安装扩展
# https://github.com/docker-library/php/issues/541
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ \
&& docker-php-ext-install gd \
&& docker-php-ext-install pdo_mysql zip mysqli \
&& pecl install mcrypt-1.0.2 \
&& docker-php-ext-enable mcrypt \
&& pecl install msgpack \
&& echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/msgpack.ini \
&& pecl install mongodb \
&& echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini \
&& pecl install redis \
&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini \
&& pecl clear-cache

# 安装composer
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
ENV TERM xterm

# 工作目录
WORKDIR /var/www 

# 监听端口
EXPOSE 9000
