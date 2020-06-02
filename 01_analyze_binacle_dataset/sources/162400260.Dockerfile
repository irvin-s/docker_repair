# Based on ubuntu 12.04
FROM ubuntu:precise

MAINTAINER Christian Simon <simon@swine.de>

# Update everything & install prequesites
RUN apt-get update &&  \
    DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential wget bzip2 \
        libpng-dev libmcrypt-dev libmcrypt4 libmhash-dev libmysqlclient-dev \
        libjpeg-dev zlib1g-dev libfreetype6-dev libfontconfig1-dev re2c \
        libgpg-error-dev uuid-dev libt1-dev libsnmp-dev libc-client2007e-dev \
        libaspell-dev libbz2-dev libc-client2007e-dev flex bison libsqlite3-dev libpq-dev \
        libcurl4-openssl-dev libmagickwand-dev libgd2-xpm-dev autoconf imagemagick \
        graphicsmagick spawn-fcgi && \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
    apt-get clean && \
    rm /var/lib/apt/lists/*_*

# Hotfixes php-4.4
## Install libdb4.6 from lucid
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://de.archive.ubuntu.com/ubuntu/pool/universe/d/db4.6/libdb4.6_4.6.21-16_amd64.deb && \
    wget http://de.archive.ubuntu.com/ubuntu/pool/universe/d/db4.6/libdb4.6-dev_4.6.21-16_amd64.deb && \
    echo "2f03a50d72f66d6c6ac976cb0ff1131a  libdb4.6-dev_4.6.21-16_amd64.deb" > md5sums && \
    echo "3f4d7da181ad71d89011983019687929  libdb4.6_4.6.21-16_amd64.deb" >> md5sums && \
    md5sum -c md5sums && \
    dpkg -i libdb4.6-dev_4.6.21-16_amd64.deb libdb4.6_4.6.21-16_amd64.deb && \
    cd && \
    rm -rf /tmp/install

## Install compatible openssl 0.9.8
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://www.openssl.org/source/openssl-0.9.8za.tar.gz && \
    echo "2f989915f8fea49aa1bc37aa58500cce  openssl-0.9.8za.tar.gz" > md5sums && \
    md5sum -c md5sums && \
    tar xfz openssl-0.9.8za.tar.gz && \
    cd openssl-0.9.8za && \
    ./config --prefix=/usr/local --openssldir=/usr/local/openssl && \
    make && \
    make test && \
    make install && \
    cd && \
    rm -rf /tmp/install

## Symlink libraries
RUN for i in /usr/lib/x86_64-linux-gnu/*.so ; do f=`basename $i`;ln -sf x86_64-linux-gnu/$f /usr/lib/$f; done
RUN for i in /usr/lib/x86_64-linux-gnu/*.a ; do f=`basename $i`;ln -sf x86_64-linux-gnu/$f /usr/lib/$f; done

# Download PHP
ENV PHP_VERSION 4.4.9
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://museum.php.net/php4/php-${PHP_VERSION}.tar.bz2 && \
    echo "2e3b2a0e27f10cb84fd00e5ecd7a1880  php-4.4.9.tar.bz2" > md5sums && \
    md5sum -c md5sums && \
    tar xfj php-${PHP_VERSION}.tar.bz2 && \
    cd php-${PHP_VERSION} && \
    ./configure \
        --enable-fastcgi \
        --with-config-file-path=/etc/php4 \
        --with-config-file-scan-dir=/etc/php4/conf.d \
        --with-libdir=lib/x86_64-linux-gnu \
        --with-mcrypt  \
        --with-zlib \
        --with-curl \
        --disable-debug \
        --disable-rpath \
        --enable-inline-optimization \
        --with-bz2 \
        --with-zlib \
        --enable-sockets \
        --enable-sysvsem  \
        --enable-sysvshm \
        --enable-pcntl \
        --enable-mbregex \
        --with-mhash \
        --enable-zip  \
        --with-pcre-regex \
        --with-mysqli  \
        --with-mysql \
        --with-gd=shared,/usr  \
        --enable-gd-native-ttf  \
        --with-ldap \
        --with-mcrypt \
        --with-mhash   \
        --with-snmp \
        --enable-ctype \
        --with-freetype-dir=shared,/usr  \
        --with-jpeg-dir=/usr  \
        --with-t1lib=/usr  \
        --enable-bcmath \
        --with-bz2 \
        --enable-ctype \
        --with-db4 \
        --with-iconv  \
        --enable-exif \
        --enable-ftp \
        --with-gettext \
        --enable-mbstring \
        --with-imap \
        --with-imap-ssl  \
        --with-kerberos \
        --with-openssl \
        --enable-intl \
        --with-pgsql \
        --with-pdo-mysql  \
        --enable-soap  \
        --with-tidy \
        --with-libxml-dir=/usr  \
        --with-openssl  \
        --with-openssl-dir=/usr/local  \
        --with-xsl && \
    make && \
    make install && \
    rm -rf /tmp/install

# Create config directory
RUN mkdir -p /etc/php4/conf.d/

# Set location and timestamp
RUN echo "date.timezone=Europe/Berlin\ndate.default_latitude=49.08\ndate.default_longitude=11.22" > /etc/php4/conf.d/10_timezone.ini

# Enable gd lib
RUN echo "extension=gd.so" > /etc/php4/conf.d/30_gd.ini

# Build module mailparse
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://pecl.php.net/get/mailparse-2.1.6.tgz && \
    echo "0f84e1da1d074a4915a9bcfe2319ce84  mailparse-2.1.6.tgz" > md5sums && \
    md5sum -c md5sums && \
    tar xfz mailparse-2.1.6.tgz && \
    cd mailparse-2.1.6 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/install
RUN echo "extension=mailparse.so" > /etc/php4/conf.d/30_mailparse.ini

# Build module pecl_http
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://pecl.php.net/get/pecl_http-1.7.6.tgz && \
    echo "4926c17a24a11a9b1cf3ec613fad97cb  pecl_http-1.7.6.tgz" > md5sums && \
    md5sum -c md5sums && \
    tar xfz pecl_http-1.7.6.tgz && \
    cd pecl_http-1.7.6 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/install
RUN echo "extension=http.so" > /etc/php4/conf.d/30_http.ini

# Build module xdebug
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget http://pecl.php.net/get/xdebug-2.0.5.tgz && \
    echo "2d87dab7b6c499a80f0961af602d030c  xdebug-2.0.5.tgz" > md5sums && \
    md5sum -c md5sums && \
    tar xfz xdebug-2.0.5.tgz && \
    cd xdebug-2.0.5 && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/install

# Install sendmail replacement / set ip address of real mailserver to 172.17.42.1
RUN mkdir -p /tmp/install/ && \
    cd /tmp/install && \
    wget https://github.com/simonswine/mini_sendmail/archive/1.3.8-1.tar.gz  && \
    tar xvfz 1.3.8-1.tar.gz && \
    cd mini_sendmail*/ && \
    make SMTP_HOST=172.17.42.1 && \
    cp -v mini_sendmail /usr/sbin/sendmail && \
    rm -rf /tmp/install

# Test if there is stderr output
RUN bash -c "[[ $(php -i 2>&1 > /dev/null | wc -l) -ne 0 ]] && php -i > /dev/null && exit 1; exit 0"
