FROM unocha/php7:%%UPSTREAM%%

MAINTAINER orakili <docker@orakili.net>

ENV PHP_HOEDOWN_VERSION=0.6.7

# A little bit of metadata management.
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="php7-reliefweb" \
      org.label-schema.description="This service provides a php-fpm platform for the reliefweb.int Drupal site with MuPDF and Hoedown." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 ctype curl dom fpm gmp imagick json mbstring mcrypt mysql opcache openssl pdo pdo_mysql pdo_pgsql phar posix simplexml sockets xml xmlreader xmlwriter zip zlib memcached redis" \
      info.humanitarianresponse.php.sapi="fpm" \
      info.humanitarianresponse.hoedown=$PHP_HOEDOWN_VERSION \
      info.humanitarianresponse.mupdf="1.11-r1"

COPY run_fpm /

RUN mv -f /run_fpm /etc/services.d/fpm/run && \
    # Upgrade to have the proper musl library
    # needed for the build dependencies below.
    apk --update-cache upgrade && \
    # Install mutools.
    apk add \
      mupdf-tools \
      php7-gmp \
      php7-simplexml && \
    # Install dependencies to build the Hoedown php extension.
    apk add --virtual .build-dependencies \
      autoconf \
      build-base \
      file \
      git \
      gzip \
      patch \
      php7-dev \
      re2c \
      tar && \
    cd /tmp && \
    # Build and install php-ext-hoedown.
    git clone --recursive --depth=1 --branch=$PHP_HOEDOWN_VERSION https://github.com/reliefweb/php-ext-hoedown.git /tmp/php-ext-hoedown && \
    cd /tmp/php-ext-hoedown && \
    phpize && ./configure && make && make test && make install && \
    cd /tmp && rm -rf /tmp/php* && \
    echo "extension=/usr/lib/php7/modules/hoedown.so" > /etc/php7/conf.d/hoedown.ini && \
    # Remove build dependencies.
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/*

EXPOSE 9000

# Volumes
# - Conf: /etc/php7/ (php-fpm.conf, php.ini, conf.d)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
