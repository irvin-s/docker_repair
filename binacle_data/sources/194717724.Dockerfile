# PHPUnit Docker Container.
FROM alpine:latest
MAINTAINER Julien Breux <julien.breux@gmail.com>

ENV PEAR_PACKAGES foo

WORKDIR /tmp

RUN apk --no-cache add \
        bash \
        ca-certificates \
        git \
        curl \
        unzip \
        php7 \
        php7-xml \
        php7-exif \
        php7-zip \
        php7-xmlreader \
        php7-zlib \
        php7-opcache \
        php7-mcrypt \
        php7-openssl \
        php7-curl \
        php7-json \
        php7-dom \
        php7-phar \
        php7-mbstring \
        php7-bcmath \
        php7-pdo \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-pdo_mysql \
        php7-soap \
        php7-xdebug \
        php7-pcntl \
        php7-ctype \
        php7-session \
        php7-tokenizer \
    && php -r "copy('https://pear.php.net/go-pear.phar', 'go-pear.phar');" \
    && php go-pear.phar \
    && php -r "unlink('go-pear.phar');" \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/bin --filename=composer \
    && php -r "unlink('composer-setup.php');" \
    && composer require "phpunit/phpunit:~5.7.5" --prefer-source --no-interaction \
    && composer require "phpunit/php-invoker" --prefer-source --no-interaction \
    && ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit \
    && sed -i 's/nn and/nn, Julien Breux (Docker) and/g' /tmp/vendor/phpunit/phpunit/src/Runner/Version.php \

    # Enable X-Debug
    && sed -i 's/\;z/z/g' /etc/php7/conf.d/xdebug.ini \
    && php -m | grep -i xdebug

ONBUILD RUN [ $PEAR_PACKAGES != "foo" ] || exit 0 && pear install $PEAR_PACKAGES

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["/usr/local/bin/phpunit"]
CMD ["--help"]
