#
# PHP Dockerfile
# 满足laravel5.2等项目需求
#
# https://github.com/ibbd/dockerfile-php-fpm/php-fpm-ext
#
# sudo docker build -t ibbd/php-fpm-ext ./
#

# Pull base image.
FROM ibbd/php-fpm

MAINTAINER Alex Cai "cyy0523xc@gmail.com"

# Install modules
# composer需要先安装zip
# pecl install imagick时需要libmagickwand-dev。但是这个安装的东西有点多，python2.7也安装了
RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        libmagickwand-dev \
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
#
# install imagick 报错如下
# checking ImageMagick MagickWand API configuration program... configure: error: not found. Please provide a path to MagickWand-config or Wand-config program.
# ERROR: `/tmp/pear/temp/imagick/configure --with-php-config=/usr/local/bin/php-config --with-imagick' failed
# 原因：由于安装imagick扩展时需要依赖ImageMagick的函数库，因此必须要先安装ImageMagick, 但是安装了却依然不行。官网上有人评论需要安装libmagickwand-dev
# 解决：apt-get install libmagickwand-dev 
#
# 注意：msgpack 2.0.0需要php7
    #&& pecl install msgpack-beta \
    #&& pecl install mongo \
    #&& echo "extension=mongo.so" > /usr/local/etc/php/conf.d/mongo.ini \
# 2016-03-09 增加mysql扩展
# iconv tokenizer pdo mbstring: 已经包含在基础镜像里
RUN  docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli mysql \
    #&& pecl install memcache \
    #&& echo "extension=memcache.so" > /usr/local/etc/php/conf.d/memcache.ini \
    #&& pecl install imagick \
    #&& echo "extension=imagick.so" > /usr/local/etc/php/conf.d/imagick.ini \
    && pecl clear-cache

# Define mountable directories.
VOLUME /var/www

# 工作目录
WORKDIR /var/www 

EXPOSE 9000
