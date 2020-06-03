FROM php:7.0-fpm-alpine

MAINTAINER Minho <longfei6671@163.com>

COPY usr/local/lib/php/extensions/no-debug-non-zts-20151012 /usr/local/lib/php/extensions/no-debug-non-zts-20151012

ADD conf/php.ini /usr/local/etc/php/php.ini
ADD conf/www.conf /usr/local/etc/php-fpm.d/www.conf

ENV IMAGICK_VERSION 3.4.2

#Alpine packages
RUN apk add --update imagemagick-dev \
	libc-dev \
	autoconf \
	freetype-dev \
	libjpeg-turbo-dev \
	libpng-dev \
	libmcrypt-dev \
	libpcre32 \
	bzip2 \
	bzip2-dev \
	libbz2 \
	libmemcached-dev \
	cyrus-sasl-dev \
	binutils \
	ca-certificates \
	tzdata \
	&& rm -rf /var/cache/apk/* \

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone
	
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install gd \
        && docker-php-ext-install mysqli \
        && docker-php-ext-install bz2 \
        && docker-php-ext-install zip \
        && docker-php-ext-install pdo \
        && docker-php-ext-install pdo_mysql \
        && docker-php-ext-install opcache \
		&& echo "extension=memcached.so" > /usr/local/etc/php/conf.d/memcached.ini \
		&& echo "extension=redis.so" > /usr/local/etc/php/conf.d/phpredis.ini \
		&& echo "extension=phalcon.so" > /usr/local/etc/php/conf.d/phalcon.ini \
		&& echo "extension=igbinary.so" > /usr/local/etc/php/conf.d/igbinary.ini \
		&& echo "extension=bcmath.so" > /usr/local/etc/php/conf.d/bcmath.ini \
		&& echo "zend_extension=xdebug.so" >> /usr/local/etc/php/conf.d/xdebug.ini \
		&& echo "extension=imagick.so" >> /usr/local/etc/php/conf.d/imagick.ini

#ImageMagick
RUN set -xe && \
	curl -LO https://github.com/ImageMagick/ImageMagick/archive/6.9.6-8.tar.gz && \
	tar xzf 6.9.6-8.tar.gz && cd ImageMagick-6.9.6-8 && ./configure --with-bzlib=yes --with-fontconfig=yes --with-freetype=yes --with-gslib=yes --with-gvc=yes --with-jpeg=yes --with-jp2=yes --with-png=yes --with-tiff=yes && make clean && make && make install && \
	make clean && ldconfig /usr/local/lib
	
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
RUN ln -s usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

RUN apk del gcc g++ make tzdata autoconf ;



EXPOSE 9000

CMD ["php-fpm"]