FROM coderstephen/php7:latest

ENV HOME=/root
ENV ATOUM_VERSION=~2.0

RUN echo 'deb http://cz.archive.ubuntu.com/ubuntu utopic main universe' >> /etc/apt/sources.list && \
    apt-get update -y && \
    apt-get install -y wget git libzip-dev

WORKDIR /usr/local/src/php
ENV PHP_DIR /usr/local/php

RUN git pull origin && \
    ./buildconf && \
    ./configure \
        --prefix=$PHP_DIR \
        --with-config-file-path=$PHP_DIR \
        --with-config-file-scan-dir=$PHP_DIR/conf.d \
        --with-apxs2=/usr/bin/apxs2 \
        --with-libdir=/lib/x86_64-linux-gnu \
        --with-zlib \
        --enable-mbstring \
        --with-openssl \
        --with-libzip --enable-zip \
        --without-pear && \
    make && \
    make install && \
    ln -sf /usr/local/php/bin/php /usr/local/bin/php && \
    ln -sf /usr/local/php/bin/phpize /usr/local/bin/phpize && \
    ln -sf /usr/local/php/bin/php-config /usr/local/bin/php-config

RUN mkdir -p /usr/local/php/conf.d
RUN echo "memory_limit=-1" >> /usr/local/php/conf.d/memory.ini && \
    echo "date.timezone=Europe/Paris" >> /usr/local/php/conf.d/date.timezone.ini

RUN wget -O /usr/local/bin/composer https://getcomposer.org/composer.phar && \
    chmod +x /usr/local/bin/composer

WORKDIR /usr/local/src
RUN git clone https://github.com/FriendsOfPHP/pickle.git && \
    cd pickle && composer install --prefer-dist --optimize-autoloader --no-dev && \
    ln -sf /usr/local/src/pickle/bin/pickle /usr/local/bin/pickle && \
    chmod +x /usr/local/bin/pickle

ADD bin/entrypoint /sbin/entrypoint
RUN chmod +x /sbin/entrypoint

ADD bin/atoum /usr/local/bin/atoum
RUN chmod +x /usr/local/bin/atoum

ADD https://raw.githubusercontent.com/atoum/atoumsay/master/atoumsay /usr/local/bin/atoum-say
RUN chmod +x /usr/local/bin/atoum-say

RUN echo "<?php" > /.autoloaders.atoum.php
RUN echo "<?php" > /.extensions.atoum.php
ADD files/.atoum.php /.atoum.php
ADD files/.bootstrap.atoum.php /.bootstrap.atoum.php

RUN composer global require atoum/atoum:$ATOUM_VERSION

VOLUME /src
WORKDIR /src

ENTRYPOINT ["/sbin/entrypoint"]
