#BUILD_PUSH=hub,quay
#BUILD_PUSH_TAG_FROM=PHP_VERSION
FROM bigm/base-deb-tools

# compile PHP 5.6 (cli and fpm)
# based on https://github.com/docker-library/php/blob/master/5.6/fpm/Dockerfile

# persistent / runtime deps
RUN /xt/tools/_apt_install ca-certificates curl libpcre3 librecode0 libsqlite3-0 libxml2

# phpize deps
RUN /xt/tools/_apt_install autoconf file g++ gcc libc-dev make pkg-config re2c

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
	xz-utils

RUN gpg --keyserver pool.sks-keyservers.net --recv-keys 6E4F6AB321FDC07F2C332E3AC2BF0BC433CFC8B3 0BD78B5F97500D450838F95DFE857D9A90D90EC1

ENV PHP_VERSION 5.6.20

COPY compile-php.sh /tmp/compile-php.sh
RUN /tmp/compile-php.sh && rm /tmp/compile-php.sh

COPY tools/* /xt/tools/

#install very common extensions
RUN /xt/tools/_apt_install libpng12-dev libjpeg-dev libbz2-dev libxslt1-dev libssh2-1-dev libmcrypt-dev
RUN /xt/tools/php_compile_extension gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& /xt/tools/php_compile_extension zip \
	&& /xt/tools/php_compile_extension mbstring \
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

RUN yes "" | pecl install ssh2-0.12 \
	&& echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ext-ssh2.ini

RUN yes "" | pecl install xdebug \
		&& echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20131226/xdebug.so" > /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.remote_enable = on" >> /usr/local/etc/ext-xdebug.ini \
    && echo "xdebug.remote_connect_back = on" >> /usr/local/etc/ext-xdebug.ini \
    && echo 'xdebug.idekey = "PHPSTORM"' >> /usr/local/etc/ext-xdebug.ini

RUN yes "" | pecl install APCu-4.0.10 \
	&& echo "extension=apcu.so" > /usr/local/etc/php/conf.d/ext-apcu.ini

# stable=2.2.7
ENV MEMCACHED_VERSION 2.2.0
RUN /xt/tools/_apt_install libmemcached-dev \
	&& pecl install igbinary \
	&& /xt/tools/_download /tmp/memcached.tgz https://pecl.php.net/get/memcached-${MEMCACHED_VERSION}.tgz \
	&& cd /tmp && tar xf memcached.tgz \
	&& cd /tmp/memcached-${MEMCACHED_VERSION} \
	&& phpize \
	&& ./configure --disable-memcached-sasl \
	&& make \
	&& make install \
	&& echo "extension=igbinary.so" > /usr/local/etc/php/conf.d/ext-igbinary.ini \
	&& echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

RUN /xt/tools/_apt_install libmagickwand-dev \
	&& yes "" | pecl install imagick \
	&& echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

RUN	yes "" | pecl install mongo \
	&& echo "extension=mongo.so" > /usr/local/etc/php/conf.d/ext-mongo.ini

#.install very common extensions

## Install HHVM
#RUN curl http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - \
#	&& echo "deb http://dl.hhvm.com/ubuntu trusty main" | tee /etc/apt/sources.list.d/hhvm.list \
#	&& /xt/tools/_apt_install hhvm

# composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
# some pear libraries
RUN pear install SQL_Parser-0.6.0

# wkhtmltopdf - http://wkhtmltopdf.org/downloads.html
RUN /xt/tools/_apt_install libxext6 fontconfig xfonts-base xfonts-75dpi libxrender-dev \
	&& /xt/tools/_download /tmp/wkhtmltox.deb http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb \
	&& dpkg -i /tmp/wkhtmltox.deb

# translate-toolkit
RUN /xt/tools/_apt_install translate-toolkit

RUN /xt/tools/_enable_ssmtp \
	&& echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/sendmail.ini

# another PDF tool
RUN /xt/tools/_apt_install pdftk

COPY etc/php-fpm.conf /usr/local/etc/
COPY etc/fpm.d/* /usr/local/etc/fpm.d/
COPY startup/* /xt/startup/
ADD supervisor/* /etc/supervisord.d/

RUN mkdir -p /var/www/html
WORKDIR /var/www

ENV PHP_TIMEZONE Europe/London
ENV PHP_CONF_VERSION production

RUN echo "xdebug.profiler_enable = 0" >> /usr/local/etc/ext-xdebug.ini \
	&& echo "xdebug.profiler_enable_trigger = 1" >> /usr/local/etc/ext-xdebug.ini \
	&& echo "xdebug.trace_enable_trigger = 1" >> /usr/local/etc/ext-xdebug.ini

EXPOSE 9000
# .compile PHP 5.6 (cli and fpm)

