FROM dockette/alpine:3.7

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ADD conf/ci.ini /etc/php7.1/conf.d/

ENV PHP_DIR=/usr/bin
ENV PHP_BIN=$PHP_DIR/php
ENV PHPXD_BIN=$PHP_DIR/phpxd
ENV COMPOSER_DIR=/usr/bin/
ENV COMPOSER_BIN=$COMPOSER_DIR/composer
ENV TZ=Europe/Prague

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    # DEPENDENCIES #############################################################
    apk update && apk upgrade && apk --no-cache add bash git ca-certificates curl openssh && \
    # PHP ######################################################################
    apk add --update \
        php7@testing \
        php7-apcu@testing \
        php7-bcmath@testing \
        php7-bz2@testing \
        php7-calendar@testing \
        php7-cgi@testing \
        php7-ctype@testing \
        php7-curl@testing \
        php7-dom@testing \
        php7-fileinfo@testing \
        php7-gettext@testing \
        php7-gd@testing \
        php7-iconv@testing \
        php7-imap@testing \
        php7-intl@testing \
        php7-json@testing \
        php7-ldap@testing \
        php7-mbstring@testing \
        php7-mcrypt@testing \
        php7-mysqli@testing \
        php7-mysqlnd@testing \
        php7-openssl@testing \
        php7-pdo@testing \
        php7-pdo_mysql@testing \
        php7-pdo_pgsql@testing \
        php7-pdo_sqlite@testing \
        php7-phar@testing \
        php7-pgsql@testing \
        php7-session@testing \
        php7-simplexml@testing \
        php7-soap@testing \
        php7-sqlite3@testing \
        php7-tokenizer@testing \
        php7-xdebug@testing \
        php7-xml@testing \
        php7-xml@testing \
        php7-xmlrpc@testing \
        php7-xmlreader@testing \
        php7-xmlwriter@testing \
        php7-xsl@testing \
        php7-zip@testing \
        php7-zlib@testing && \
        cp /etc/php7/conf.d/xdebug.ini /etc/php7.1/conf.d/xdebug.ini && \
        sed -i -- 's/zend/;zend/g' /etc/php7.1/conf.d/xdebug.ini && \
        echo "php -dzend_extension=xdebug.so \$@" >> $PHPXD_BIN && \
        chmod +x $PHPXD_BIN && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=$COMPOSER_DIR --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

CMD php
