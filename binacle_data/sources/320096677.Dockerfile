FROM dockette/alpine:3.5

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ADD conf/ci.ini /etc/php7/conf.d/

ENV PHP_DIR=/usr/bin
ENV PHP_BIN=$PHP_DIR/php
ENV PHPXD_BIN=$PHP_DIR/phpxd
ENV COMPOSER_DIR=/usr/bin/
ENV COMPOSER_BIN=$COMPOSER_DIR/composer
ENV TZ=Europe/Prague

RUN echo '@community http://nl.alpinelinux.org/alpine/v3.5/community' >> /etc/apk/repositories && \
    # DEPENDENCIES #############################################################
    apk update && apk upgrade && apk --no-cache add bash git ca-certificates curl openssh && \
    # PHP ######################################################################
    apk add --update \
        php7 \
        php7-apcu@community \
        php7-bcmath@community \
        php7-bz2@community \
        php7-calendar@community \
        php7-cgi@community \
        php7-common@community \
        php7-ctype@community \
        php7-curl@community \
        php7-gettext@community \
        php7-gd@community \
        php7-iconv@community \
        php7-imap@community \
        php7-intl@community \
        php7-json@community \
        php7-ldap@community \
        php7-mbstring@community \
        php7-mcrypt@community \
        php7-mysqli@community \
        php7-mysqlnd@community \
        php7-openssl@community \
        php7-pdo@community \
        php7-pdo_mysql@community \
        php7-pdo_pgsql@community \
        php7-pdo_sqlite@community \
        php7-phar@community \
        php7-pgsql@community \
        php7-session@community \
        php7-soap@community \
        php7-sqlite3@community \
        php7-xdebug@community \
        php7-xml@community \
        php7-xmlrpc@community \
        php7-xmlreader@community \
        php7-xsl@community \
        php7-zip@community \
        php7-zlib@community && \
        sed -i -- 's/zend/;zend/g' /etc/php7/conf.d/xdebug.ini && \
        echo "php -dzend_extension=xdebug.so \$@" >> $PHPXD_BIN && \
        chmod +x $PHPXD_BIN && \
    # SYMLINKS PHP7 -> PHP #####################################################
    ln -s /etc/php7 /etc/php && \
    ln -s /usr/bin/php7 /usr/bin/php && \
    ln -s /usr/lib/php7 /usr/lib/php && \
    # COMPOSER #################################################################
    curl -sS https://getcomposer.org/installer | php -- --install-dir=$COMPOSER_DIR --filename=composer && \
    composer global require "hirak/prestissimo:^0.3" && \
    # CLEAN UP #################################################################
    rm -rf /var/cache/apk/*

CMD php
