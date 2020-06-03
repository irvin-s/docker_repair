# centos7 php7
FROM local/c7-systemd

MAINTAINER yjc@52fhy.com

ENV PHP_VERSION 7.0.12
ENV PHP_URL="http://cn2.php.net/distributions/php-7.0.12.tar.bz2"

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
	&& tar zxvf /libmcrypt-2.5.7.tar.gz \
    && cd /libmcrypt-2.5.7 && ./configure && make && make install && cd - / && rm -rf /libmcrypt* \
    && tar zxvf /mhash-0.9.9.9.tar.gz && cd mhash-0.9.9.9 && ./configure && make && make install && cd - / && rm -rf /mhash* \
    && tar zxvf /mcrypt-2.6.8.tar.gz && cd mcrypt-2.6.8 && LD_LIBRARY_PATH=/usr/local/lib ./configure && make && make install && cd - / && rm -rf /mcrypt* 
	
RUN wget -O /php.tar.bz2 "$PHP_URL" \
    && tar jxvf /php.tar.bz2 && cd php-${PHP_VERSION}/ \
    && ./configure --prefix=/usr/local/php --with-config-file-scan-dir=/usr/local/php/etc/ --enable-inline-optimization --enable-opcache --enable-session --enable-fpm --with-fpm-user=www --with-fpm-group=www --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-sqlite --with-sqlite3 --with-gettext --enable-mbregex --enable-mbstring --enable-xml --with-iconv --with-mcrypt --with-mhash --with-openssl --enable-bcmath --enable-soap --with-xmlrpc --with-libxml-dir --enable-pcntl --enable-shmop --enable-sysvmsg --enable-sysvsem --enable-sysvshm --enable-sockets --with-curl --with-curlwrappers --with-zlib --enable-zip --with-bz2 --with-gd --enable-gd-native-ttf --with-jpeg-dir --with-png-dir --with-freetype-dir --with-iconv-dir --with-readline \
    && make && make install \
    && cp php.ini-production php.ini \
    && cp php.ini* /usr/local/php/etc/ \
    && cp /usr/local/php/etc/php-fpm.conf.default  /usr/local/php/etc/php-fpm.conf \
    && make clean && yum clean all  && cd - && rm -rf /php-${PHP_VERSION}/

RUN wget http://nginx.org/download/nginx-1.11.1.tar.gz \
    && tar zxvf nginx-1.11.1.tar.gz && cd nginx-1.11.1 \
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
    && cd ../ && rm -rf php-7.0.7* && rm -rf nginx-1.11.1/ \

EXPOSE 80
CMD ["/usr/sbin/init"]
