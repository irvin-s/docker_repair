#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=PHP_VERSION
FROM bigm/base-deb-tools

# compile PHP 7.0 (cli and fpm)
# based on https://github.com/docker-library/php/blob/master/7.0/fpm/Dockerfile

# persistent / runtime deps
RUN /xt/tools/_apt_install ca-certificates curl libpcre3 librecode0 libsqlite3-0 libxml2

# phpize deps
RUN /xt/tools/_apt_install autoconf file g++ gcc libc-dev make pkg-config re2c \
    ca-certificates curl libedit2

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

#prepare what will be compiled
ENV PHP_EXTRA_CONFIGURE_ARGS --enable-fpm --with-fpm-user=root --with-fpm-group=root
RUN /xt/tools/_apt_install $PHP_EXTRA_BUILD_DEPS \
    bzip2 \
    libcurl4-openssl-dev \
    libpcre3-dev \
    libreadline6-dev \
    libssl-dev \
    libxml2-dev \
    librecode-dev \
    libsqlite3-dev \
    xz-utils \
    libedit-dev

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3 0BD78B5F97500D450838F95DFE857D9A90D90EC1 1A4E8B7277C42E53DBA9C7B9BCAA30EA9C0D5763

# wkhtmltopdf - http://wkhtmltopdf.org/downloads.html
RUN /xt/tools/_apt_install libxext6 fontconfig xfonts-base xfonts-75dpi libxrender-dev libjpeg-dev \
    && /xt/tools/_download /tmp/wkhtmltox.deb http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb \
    && dpkg -i /tmp/wkhtmltox.deb

ENV PHP_VERSION 7.0.6

COPY compile-php.sh /tmp/compile-php.sh
RUN /tmp/compile-php.sh && rm /tmp/compile-php.sh

 #install very common extensions
RUN /xt/tools/_apt_install libpng12-dev libjpeg-dev libbz2-dev libxslt1-dev libssh2-1-dev libmcrypt-dev
COPY tools/* /xt/tools/
RUN /xt/tools/php_compile_extension gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && /xt/tools/php_compile_extension zip \
    && /xt/tools/php_compile_extension pdo_mysql \
    && /xt/tools/php_compile_extension bz2 \
    && /xt/tools/php_compile_extension xsl \
    && /xt/tools/php_compile_extension xmlrpc \
    && /xt/tools/php_compile_extension wddx \
    && /xt/tools/php_compile_extension sockets \
    && /xt/tools/php_compile_extension exif \
    && /xt/tools/php_compile_extension ftp \
    && /xt/tools/php_compile_extension gettext \
    && /xt/tools/php_compile_extension mcrypt \
    && /xt/tools/php_compile_extension soap \
    && /xt/tools/php_compile_cleanup

#sysvsem + sysvshm
#sysvmsg?
#shmop?
#gmp ?
#mysql ?
#mysqli ?

RUN yes "" | pecl install xdebug \
    && echo "zend_extension=xdebug.so" > /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.remote_enable = on" >> /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.remote_connect_back = on" >> /usr/local/etc/ext-xdebug.ini \
    && echo 'xdebug.idekey = "PHPSTORM"' >> /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.profiler_enable = 0" >> /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.profiler_enable_trigger = 1" >> /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.trace_enable_trigger = 1" >> /usr/local/etc/ext-xdebug.ini

#TODO ssh2 not compiling under 7
#RUN yes "" | pecl install ssh2-0.12 \
#	&& echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ext-ssh2.ini
RUN cd /tmp && git clone https://git.php.net/repository/pecl/networking/ssh2.git && cd /tmp/ssh2 \
    && phpize && ./configure && make && make install \
    && echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ext-ssh2.ini \
    && rm -rf /tmp/ssh2

# #.install very common extensions

# composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# some pear libraries
RUN pear install SQL_Parser-0.7.0

# translate-toolkit
RUN /xt/tools/_apt_install translate-toolkit

RUN /xt/tools/_enable_ssmtp \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/sendmail.ini

# another PDF tool
RUN /xt/tools/_apt_install pdftk

ADD root/ /
ADD startup/* /xt/startup/
ADD supervisor.d/* /etc/supervisord.d/

RUN mkdir -p /var/www/html
WORKDIR /var/www

ENV PHP_TIMEZONE Europe/London
ENV PHP_CONF_VERSION production

EXPOSE 9000
# .compile PHP 7.0 (cli and fpm)

RUN /xt/tools/_apt_install libmagickwand-dev git \
    && yes "" | pecl install imagick-3.4.1 \
    && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

#TODO we have to replace mongo driver with mongodb under 7
RUN	yes "" | pecl install mongodb \
	&& echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/ext-mongo.ini

# TODO igbinary doesn't compile under 7 - https://github.com/igbinary/igbinary
# TODO memcached doesn't compile under 7 - https://github.com/php-memcached-dev/php-memcached/issues/194
# TODO use --enable-memcached-igbinary
# stable=2.2.7
#ENV MEMCACHED_VERSION 2.2.0
#RUN /xt/tools/_apt_install libmemcached-dev \
#	&& pecl install igbinary \
#	&& /xt/tools/_download /tmp/memcached.tgz https://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz \
#	&& cd /tmp && tar xf memcached.tgz \
#	&& cd /tmp/memcached-${MEMCACHED_VERSION} \
#	&& phpize \
#	&& ./configure --disable-memcached-sasl \
#	&& make \
#	&& make install \
#	&& echo "extension=igbinary.so" > /usr/local/etc/php/conf.d/ext-igbinary.ini \
#	&& echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

#RUN cd /tmp && /xt/tools/_download /tmp/apcu.tgz https://pecl.php.net/get/APCu \
#    && cd /tmp && tar xf apcu.tgz && cd /tmp/apcu-5.1.3 \
#	&& phpize && ./configure --enable-apcu --enable-apcu-bc && make && make install \
#    && rm -rf /tmp/apcu-5.1.3
RUN yes "" | pecl install APCu-5.1.3 \
    && yes "" | pecl install apcu_bc-beta \
	&& echo "extension=apcu.so" > /usr/local/etc/php/conf.d/ext-apcu.ini \
	&& echo "extension=apc.so" >> /usr/local/etc/php/conf.d/ext-apcu.ini

# we need msgpack until igbinary for PHP7 is not fixed https://github.com/igbinary/igbinary7/issues/3
RUN yes "" | pecl install msgpack-beta \
    && echo "extension=msgpack.so" > /usr/local/etc/php/conf.d/ext-msgpack.ini

RUN cd /tmp && git clone https://github.com/igbinary/igbinary7.git && cd /tmp/igbinary7 \
    && phpize && ./configure CFLAGS="-O2 -g" --enable-igbinary && make && make install \
    && rm -rf /tmp/igbinary7 \
    && echo "extension=igbinary.so" > /usr/local/etc/php/conf.d/ext-igbinary.ini
RUN /xt/tools/_apt_install libmemcached-dev \
    && cd /tmp && git clone -b php7 https://github.com/php-memcached-dev/php-memcached && cd /tmp/php-memcached \
    && phpize && ./configure --enable-memcached-igbinary --disable-memcached-sasl && make && make install \
    && rm -rf /tmp/php-memcached \
    && echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

RUN echo "session.serialize_handler=php" > /usr/local/etc/php/conf.d/zzzzzzzz.txt
