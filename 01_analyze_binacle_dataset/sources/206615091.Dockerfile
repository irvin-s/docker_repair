FROM alpine:latest
MAINTAINER Patrik Votoček <patrik@votocek.cz>

ENV COMPOSER_NO_INTERACTION=1 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_DISCARD_CHANGES=1

RUN apk --update --no-cache upgrade && \
    apk --update --no-cache add ca-certificates openssl git openssh \
        php5 \
        php5-ctype \
        php5-snmp \
        php5-soap \
        php5-sockets \
        php5-sqlite3 \
        php5-xml \
        php5-xmlreader \
        php5-xmlrpc \
        php5-xsl \
        php5-zip \
        php5-zlib \
        php5-openssl \
        php5-pcntl \
        php5-pdo \
        php5-pdo_mysql \
        php5-pdo_pgsql \
        php5-pdo_sqlite \
        php5-pgsql \
        php5-phar \
        php5-posix \
        php5-ftp \
        php5-gd \
        php5-gettext \
        php5-gmp \
        php5-iconv \
        php5-intl \
        php5-json \
        php5-mcrypt \
        php5-opcache \
        php5-bcmath \
        php5-bz2 \
        php5-curl \
        php5-dev && \
    wget -q https://getcomposer.org/download/1.3.1/composer.phar -O /usr/bin/composer && \
    echo "f3e0faddf49039edf40ab62c497e0926286e8871a50228fd90ea91dcebbd15c3 */usr/bin/composer" | sha256sum -c - && \
    chmod +x /usr/bin/composer && \
    touch /etc/php5/conf.d/zzz.ini && \
    echo "date.timezone = Europe/Prague" >> /etc/php5/conf.d/zzz.ini && \
    echo "memory_limit = -1" >> /etc/php5/conf.d/zzz.ini && \
    echo "upload_max_filesize = 128M" >> /etc/php5/conf.d/zzz.ini && \
    echo "realpath_cache_size = 256k" >> /etc/php5/php.ini && \
    echo "realpath_cache_ttl = 3600" >> /etc/php5/php.ini && \
    echo "opcache.save_comments = 1" >> /etc/php5/php.ini && \
    echo "opcache.fast_shutdown = 1" >> /etc/php5/php.ini && \
    echo "opcache.revalidate_freq = 0" >> /etc/php5/php.ini && \
    echo "opcache.revalidate_path = Off" >> /etc/php5/php.ini && \
    echo "opcache.max_accelerated_files = 65000" >> /etc/php5/php.ini && \
    echo "opcache.memory_consumption = 3072"

CMD ["php", "-a"]
