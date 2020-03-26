FROM alpine:latest
MAINTAINER Patrik Votoček <patrik@votocek.cz>

ENV COMPOSER_NO_INTERACTION=1 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_DISCARD_CHANGES=1

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add ca-certificates openssl git openssh \
        php7 \
        php7-ctype \
        php7-snmp \
        php7-soap \
        php7-sockets \
        php7-sqlite3 \
        php7-xml \
        php7-xmlreader \
        php7-xmlrpc \
        php7-xsl \
        php7-zip \
        php7-zlib \
        php7-openssl \
        php7-pcntl \
        php7-pdo \
        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-pgsql \
        php7-phar \
        php7-posix \
        php7-session \
        php7-ftp \
        php7-gd \
        php7-gettext \
        php7-gmp \
        php7-iconv \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-opcache \
        php7-bcmath \
        php7-bz2 \
        php7-curl \
        php7-dev \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    wget -q https://getcomposer.org/download/1.3.1/composer.phar -O /usr/bin/composer && \
    echo "f3e0faddf49039edf40ab62c497e0926286e8871a50228fd90ea91dcebbd15c3 */usr/bin/composer" | sha256sum -c - && \
    chmod +x /usr/bin/composer && \
    touch /etc/php7/conf.d/zzz.ini && \
    echo "date.timezone = Europe/Prague" >> /etc/php7/conf.d/zzz.ini && \
    echo "memory_limit = -1" >> /etc/php7/conf.d/zzz.ini && \
    echo "upload_max_filesize = 128M" >> /etc/php7/conf.d/zzz.ini && \
    echo "realpath_cache_size = 256k" >> /etc/php7/php.ini && \
    echo "realpath_cache_ttl = 3600" >> /etc/php7/php.ini && \
    echo "opcache.save_comments = 1" >> /etc/php7/php.ini && \
    echo "opcache.fast_shutdown = 1" >> /etc/php7/php.ini && \
    echo "opcache.revalidate_freq = 0" >> /etc/php7/php.ini && \
    echo "opcache.revalidate_path = Off" >> /etc/php7/php.ini && \
    echo "opcache.max_accelerated_files = 65000" >> /etc/php7/php.ini && \
    echo "opcache.memory_consumption = 3072"

CMD ["php", "-a"]
