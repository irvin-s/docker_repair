#FROM centos:centos6.8
FROM daocloud.io/centos:6.8

MAINTAINER yjc@52fhy.com

# php
ENV PHP_VERSION 5.6.33
ENV PHP_URL="http://cn2.php.net/distributions/php-${PHP_VERSION}.tar.bz2"

# nginx
ENV NGINX_VERSION 1.12.2

# redis
ENV REDIS_VER 3.2.6

# php-ext	
ENV SWOOLE_VER 1.10.1
# https://github.com/swoole/swoole-src/archive/v1.10.1.tar.gz

ENV PHPREDIS_VER 3.1.2
# php5 need yar < 2.0
ENV YAR_VER 1.2.5
ENV PHP_INI_FILE="/usr/local/php/etc/php.ini"

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN yum install -y gcc gcc-c++ bison autoconf wget lrzsz \
    && yum install -y make cmake libtool libtool-ltdl-devel \
    && yum install -y libjpeg-devel libpng-devel freetype-devel gd-devel \
    && yum install -y python-devel  patch \
    && yum install -y openssl openssl-devel ncurses-devel \
    && yum install -y bzip2 bzip2-devel.x86_64 unzip zlib-devel \
    && yum install -y libxml2 libxml2-devel \
    && yum install -y curl-devel \
    && yum install -y readline-devel \
    && yum install -y pcre-devel \
    && yum clean all

RUN wget -O /libmcrypt-2.5.7.tar.gz ftp://mcrypt.hellug.gr/pub/crypto/mcrypt/libmcrypt/libmcrypt-2.5.7.tar.gz \
	&& wget -O /mcrypt-2.6.8.tar.gz https://jaist.dl.sourceforge.net/project/mcrypt/MCrypt/2.6.8/mcrypt-2.6.8.tar.gz \
	&& wget -O /mhash-0.9.9.9.tar.gz https://jaist.dl.sourceforge.net/project/mhash/mhash/0.9.9.9/mhash-0.9.9.9.tar.gz \
	&& tar zxvf /libmcrypt-2.5.7.tar.gz && cd /libmcrypt-2.5.7 && ./configure && make && make install && cd - / && rm -rf /libmcrypt* \
	&& tar zxvf /mhash-0.9.9.9.tar.gz && cd mhash-0.9.9.9 && ./configure && make && make install && cd - / && rm -rf /mhash* \
	&& tar zxvf /mcrypt-2.6.8.tar.gz && cd mcrypt-2.6.8 && LD_LIBRARY_PATH=/usr/local/lib ./configure && make && make install && cd - / && rm -rf /mcrypt* 
	
RUN wget -O /php-${PHP_VERSION}.tar.bz2 "$PHP_URL" \
    && tar jxvf /php-${PHP_VERSION}.tar.bz2 && cd php-${PHP_VERSION}/ \
    && ./configure --prefix=/usr/local/php --with-config-file-scan-dir=/usr/local/php/etc/ --enable-inline-optimization --enable-opcache --enable-session --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --with-gettext --enable-mbregex --enable-mbstring --enable-xml --with-iconv --with-mcrypt --with-mhash --with-openssl --enable-bcmath --enable-soap --with-xmlrpc --with-libxml-dir --enable-pcntl --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-sockets --with-curl --with-curlwrappers --with-zlib --enable-zip --with-bz2 --with-gd --enable-gd-native-ttf --with-jpeg-dir --with-png-dir --with-freetype-dir --with-iconv-dir --with-readline \
    && make && make install \
    && cp php.ini-production php.ini \
    && cp php.ini* /usr/local/php/etc/ \
    && cp /usr/local/php/etc/php-fpm.conf.default  /usr/local/php/etc/php-fpm.conf \
    && make clean && yum clean all  && cd - && rm -rf /php-${PHP_VERSION}* \
	&& ln -sf /usr/local/php/bin/* /usr/bin/ \
    && ln -sf /usr/local/php/sbin/* /usr/bin/ \	
	&& sed -i "s/;date.timezone =/date.timezone =PRC/" /usr/local/php/etc/php.ini

RUN useradd www

RUN wget -O /nginx-${NGINX_VERSION}.tar.gz http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
	&& echo 'install nginx' \
    && tar zxvf /nginx-${NGINX_VERSION}.tar.gz && cd nginx-${NGINX_VERSION} \
    && ./configure \
    --prefix=/usr/local/nginx \
    --with-http_stub_status_module  \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_sub_module \
    --with-http_gzip_static_module \
    --with-pcre \
    && make && make install \
    && ln -sf /usr/local/nginx/sbin/nginx /usr/bin  \
    && make clean && yum clean all \
    && cd ../ && rm -rf nginx-${NGINX_VERSION}*

	
RUN /usr/local/php/bin/pecl install redis swoole && \
	echo "extension=swoole.so" >> "$PHP_INI_FILE" && \
	echo "extension=redis.so" >> "$PHP_INI_FILE"
	
RUN echo 'install yar' \
	&& wget http://pecl.php.net/get/yar-${YAR_VER}.tgz \
    && tar xzf yar-${YAR_VER}.tgz && cd yar-${YAR_VER}/ \
	&& phpize \
    && ./configure \
    && make && make install \
	&& echo "extension=yar.so" >> "$PHP_INI_FILE" \
    && cd ../ && rm -rf yar-${YAR_VER}*
	
RUN wget http://download.redis.io/releases/redis-${REDIS_VER}.tar.gz -O /redis-${REDIS_VER}.tar.gz \
	&& echo 'install redis' \
    && tar xzf /redis-${REDIS_VER}.tar.gz && cd redis-${REDIS_VER} \
    && make \
	&& mkdir /usr/local/redis \
	&& cp redis.conf /usr/local/redis/ \
	&& cd src && cp  redis-benchmark redis-check-aof redis-check-rdb redis-cli redis-sentinel redis-server redis-trib.rb /usr/local/redis \
    && cd / && rm -rf redis-${REDIS_VER}*

ADD ./run.sh /run.sh
RUN chmod 755 /run.sh

CMD /run.sh && tail -f

EXPOSE 80
EXPOSE 9000

#docker build -t php56-fpm-centos68 -f Dockerfile_online .

