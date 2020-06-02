FROM php:5-cli

MAINTAINER <atom.azimov@gmail.com>

ARG DEBIAN_REPO='http://mirror.yandex.ru/debian/'

RUN echo "deb ${DEBIAN_REPO} jessie main" > /etc/apt/sources.list &&\
    apt-get update

RUN apt-get install libmcrypt4 libmcrypt-dev -y && \
    docker-php-ext-install mcrypt && \
    apt-get purge libmcrypt-dev -y

RUN apt-get install libicu52 libicu-dev -y && \
    docker-php-ext-install intl && \
    apt-get purge libicu-dev -y

RUN docker-php-ext-install bcmath

RUN docker-php-ext-install mbstring

RUN docker-php-ext-install opcache

RUN apt-get install zlib1g zlib1g-dev -y && \
    docker-php-ext-install zip &&\
    apt-get purge zlib1g-dev -y

#RUN docker-php-ext-install pdo

#RUN apt-get install -y --force-yes \
#        libpq-dev \
#        libssl-dev \
#        libssl1.0.0=1.0.1k-3+deb8u2 \
#        krb5-multidev \
#        libkrb5-3=1.12.1+dfsg-19+deb8u1 \
#        libk5crypto3=1.12.1+dfsg-19+deb8u1 \
#        libpq5 \
#        libgssapi-krb5-2=1.12.1+dfsg-19+deb8u1 \
#        libkrb5support0=1.12.1+dfsg-19+deb8u1 &&\
#    docker-php-ext-install pdo_pgsql && \
#    apt-get purge libpq-dev krb5-multidev libssl-dev -y

RUN yes | pecl install xdebug-beta && \
    XDEBUG_CONFIG=/usr/local/etc/php/conf.d/xdebug.ini && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > $XDEBUG_CONFIG &&\
    echo "xdebug.remote_enable=on" >> $XDEBUG_CONFIG &&\
    echo "xdebug.remote_mode=req" >> $XDEBUG_CONFIG &&\
    echo "xdebug.remote_port=9000" >> $XDEBUG_CONFIG &&\
    echo "xdebug.idekey=PHPSTORM" >> $XDEBUG_CONFIG &&\
    echo "xdebug.remote_host=$(ip route|awk '/default/ { print $3 }')" >> $XDEBUG_CONFIG

RUN apt-get upgrade -y &&\
    apt-get autoremove -y &&\
    apt-get clean -y &&\
    rm -rf /var/lib/apt/lists/*

COPY . /srv

WORKDIR /srv
