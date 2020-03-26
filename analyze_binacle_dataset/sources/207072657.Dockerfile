FROM unocha/php7:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <docker+ops@humanitarianresponse.info>

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
      org.label-schema.name="php7-ghosts" \
      org.label-schema.description="This service provides a php-fpm platform for the FTS/HPC Viewer Drupal 7 sites." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm ftp gd gettext iconv igbinary imagick imap intl json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop soap sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm" \
      info.humanitarianresponse.casperjs="1.1.3" \
      info.humanitarianresponse.phantomjs="2.0.0"

COPY igbinary.ini /etc/php7/conf.d/igbinary.ini

RUN \
    # Change appuser UID and GID.
    sed -i s/4000/48/g /etc/group && \
    sed -i s/4000/48/g /etc/group- && \
    sed -i s/4000/48/g /etc/passwd && \
    sed -i s/4000/48/g /etc/shadow && \
    # Install additional php libraries.
    apk add --update-cache \
      php7-ftp \
      php7-imap \
      php7-intl \
      php7-soap && \
    rm -rf /var/cache/apk/* && \
    # Build igbinary php extension.
    apk add --update-cache --virtual .build-dependencies \
      git \
      php7-dev \
      autoconf \
      g++ \
      make && \
    cd /tmp && \
    git clone https://github.com/igbinary/igbinary && \
    cd igbinary && \
    phpize7 && \
    ./configure CFLAGS="-O2 -g" --enable-igbinary --with-php-config=/usr/bin/php-config7 && \
    make && \
    make install && \
    cd .. && \
    rm -rf igbinary && \
    rm -rf /usr/include/php/ && \
    apk del .build-dependencies && \
    rm -rf /var/cache/apk/* && \
    # Add dependencies for capsper and phantom.
    apk add --update-cache \
      fontconfig \
      libc6-compat \
      python && \
    rm -rf /var/cache/apk/* && \
    # Install casper.
    curl -L -o /tmp/casperjs.zip https://github.com/n1k0/casperjs/archive/master.zip && \
    mkdir -p /opt && \
    unzip /tmp/casperjs.zip -d /opt && \
    mv /opt/casperjs-master /opt/casperjs && \
    ln -s /opt/casperjs/bin/casperjs /usr/local/bin/casperjs && \
    rm -f /tmp/casperjs.zip && \
    # Found an actual working PhantomJS at http://fabiorehm.com/blog/2015/07/22/building-a-minimum-viable-phantomjs-2-docker-image
    # It's a year old, but it's newer than the old one (1.9.8) and it works.
    # Mind you, only extract part of the archive, or our crafted passwd and shadow files wil be overwritten.
    curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
      | tar xz -C / bin etc/fonts etc/ssl lib lib64 usr/lib usr/local usr/share
