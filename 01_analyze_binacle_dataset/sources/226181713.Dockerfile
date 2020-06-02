FROM php:5.6-fpm

RUN apt-get update \
    && echo "postfix postfix/mailname string example.com" | debconf-set-selections \
    && echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections \
    && apt-get install -y \
        libz-dev \
        libmemcached11 \
        libmemcachedutil2 \
        libmemcached-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        mysql-client \
        less \
        postfix \
    && pecl install memcached-2.2.0 \
    && docker-php-ext-enable memcached \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) pdo_mysql sockets mysqli zip \
    && docker-php-ext-enable pdo_mysql mysqli gd zip \
    && apt-get purge -y libmemcached-dev \
    && apt-get autoremove -y \
    && apt-get autoclean

ARG INSTALL_XDEBUG=true
ENV INSTALL_XDEBUG ${INSTALL_XDEBUG}
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
        pecl install xdebug-2.5.5 && \
        docker-php-ext-enable xdebug \
    ;fi

RUN curl https://getcomposer.org/download/$(curl -LSs https://api.github.com/repos/composer/composer/releases/latest | grep 'tag_name' | sed -e 's/.*: "//;s/".*//')/composer.phar > /tmp/composer.phar \
    && chmod +x /tmp/composer.phar \
    && mv /tmp/composer.phar /usr/local/bin/composer \
    && curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /tmp/wp-cli.phar \
    && chmod +x /tmp/wp-cli.phar \
    && mv /tmp/wp-cli.phar /usr/local/bin/wp

CMD ["php-fpm"]

EXPOSE 9000
