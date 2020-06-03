FROM centos:centos6

RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum -y install wget tar unzip gcc zlib zlib-devel openssl openssl-devel unzip
RUN yum -y install libxml2-devel bzip2-devel curl-devel db4-devel gdbm-devel libjpeg-devel libpng-devel freetype-devel t1lib-devel.x86_64 gmp-devel libc-client-devel build-essential openldap-devel libmcrypt-devel.x86_64 gcc-c++ postgresql-devel aspell-devel pcre pcre-devel xz git

RUN ln -s /usr/lib64/libc-client.so /usr/lib/libc-client.so \
    && cp -frp /usr/lib64/libldap* /usr/lib/

RUN set -x \
    && wget http://sourceforge.net/projects/mcrypt/files/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz \
    && mkdir -p /usr/src/libmcrypt \
    && tar -zxvf libmcrypt-2.5.8.tar.gz -C /usr/src/libmcrypt --strip-components=1 \
    && rm libmcrypt-2.5.8.tar.gz \
    && pushd /usr/src/libmcrypt \
    && ./configure \
    && make && make install \
    && popd

RUN wget http://mirrors.sohu.com/php/php-5.5.9.tar.gz \
    && mkdir -p /usr/src/php \
    && tar -zxvf php-5.5.9.tar.gz -C /usr/src/php --strip-components=1 \
    && rm php-5.5.9.tar.gz \
    && pushd /usr/src/php \
    && ./configure --prefix=/opt/php --with-config-file-path=/opt/php/etc --enable-cli --enable-ftp --enable-sockets --enable-soap --enable-fileinfo --enable-bcmath --enable-calendar --with-kerberos --enable-zip --enable-pear --with-bz2 --with-curl --enable-dba --with-inifile --with-flatfile --with-cdb --with-gdbm --with-mcrypt --with-mhash --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --with-pdo-pgsql --with-pgsql --with-pspell --with-gettext --with-gmp --with-imap --with-imap-ssl --with-ldap --with-ldap-sasl --enable-mbstring --enable-mbregex --enable-exif --with-openssl --enable-fpm --with-gd --with-png-dir --with-jpeg-dir --with-freetype-dir --with-t1lib --enable-gd-native-ttf --enable-gd-jis-conv --with-libxml-dir --with-zlib \
    && make \
    && make install \
    && rm -r /usr/src/php \
    && popd

RUN git clone https://github.com/nicolasff/phpredis \
    && pushd phpredis \
    && /opt/php/bin/phpize \
    && ./configure --with-php-config=/opt/php/bin/php-config \
    && make \
    && make install \
    && popd

RUN git clone https://github.com/allegro/php-protobuf \
    && pushd php-protobuf \
    && /opt/php/bin/phpize \
    && ./configure --with-php-config=/opt/php/bin/php-config \
    && make \
    && make install \
    && popd

RUN wget http://ftp.exim.llorien.org/pcre/pcre-8.32.tar.gz \
    && mkdir -p /usr/src/pcre-8.32 \
    && tar -zxvf pcre-8.32.tar.gz -C /usr/src/pcre-8.32 --strip-components=1 \
    && rm pcre-8.32.tar.gz

RUN wget http://www.openssl.org/source/openssl-1.0.1e.tar.gz \
    && mkdir -p /usr/src/openssl-1.0.1e \
    && tar -zxvf openssl-1.0.1e.tar.gz -C /usr/src/openssl-1.0.1e --strip-components=1 \
    && rm openssl-1.0.1e.tar.gz

RUN wget http://nginx.org/download/nginx-1.4.6.tar.gz \
    && mkdir -p /usr/src/nginx \
    && tar -zxvf nginx-1.4.6.tar.gz -C /usr/src/nginx --strip-components=1 \
    && rm nginx-1.4.6.tar.gz \
    && pushd /usr/src/nginx \
    && ./configure --prefix=/opt/nginx --with-pcre=/usr/src/pcre-8.32 --with-http_gzip_static_module --with-http_ssl_module --with-openssl=/usr/src/openssl-1.0.1e \
    && make \
    && make install \
    && popd

ADD . /opt/
WORKDIR /opt

RUN cp nginx.conf /opt/nginx/conf/nginx.conf \
    && cp php.ini /opt/php/etc/ \
    && cp php-fpm.conf /opt/php/etc/

RUN tar zxvf scribed.tar.gz \
    && chown -R root:root scribed \
    && rm -f scribed.tar.gz

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python
RUN pip install supervisor \
    && echo_supervisord_conf > /etc/supervisord.conf \
    && echo "[include]" >> /etc/supervisord.conf \
    && echo "files = /etc/supervisord.d/*.conf" >> /etc/supervisord.conf \
    && mkdir -p /etc/supervisord.d \
    && cp nginxphp.conf scribed.conf /etc/supervisord.d/ \
    && rm -f nginx.conf php.ini php-fpm.conf nginxphp.conf scribed.conf Dockerfile

RUN mkdir /opt/app
RUN mkdir /opt/logs
ENV PHP_HOME /opt/php
ENV NGINX_HOME /opt/nginx
ENV PATH $PATH:$PHP_HOME/bin:$PHP_HOME/sbin:$NGINX_HOME/sbin

EXPOSE 8080
