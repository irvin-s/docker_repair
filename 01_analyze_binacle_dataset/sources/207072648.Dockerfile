FROM unocha/nodejs-builder:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Alpine based docker image.
# Includes php composer, ruby bundler, less, npm, jasmine, compass and drush.

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="unified-builder" \
      org.label-schema.description="This service provides a builder container for PHP, with node and sass helpers." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm ftp gd gettext iconv igbinary imagick imap intl json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop soap sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="cli" \
      info.humanitarianresponse.composer="1.8.4" \
      info.humanitarianresponse.drush="8.1.18-dev" \
      info.humanitarianresponse.node="8.11.3" \
      info.humanitarianresponse.npm="5.6.0" \
      info.humanitarianresponse.yarn="1.7.0" \
      info.humanitarianresponse.compass="3.2.0" \
      info.humanitarianresponse.jasmine="2.8.0" \
      info.humanitarianresponse.casperjs="1.1.3" \
      info.humanitarianresponse.phantomjs="2.0.0" \
      info.humanitarianresponse.ruby="2.3.1"

ENV DRUSH_VERSION=8 \
    DRUSH_RELEASE=8.x-dev

COPY drushrc.php /drushrc.php

RUN npm install --global \
      jasmine && \
    rm -rf /tmp/npm-* && \
    \
    apk add --update-cache \
      bash \
      ca-certificates \
      curl \
      build-base \
      git \
      gzip \
      openssh-client \
      patch \
      rsync \
      tar \
      wget \
      php7-bcmath \
      php7-bz2 \
      php7-calendar \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-exif \
      php7-iconv \
      php7-fileinfo \
      php7-ftp \
      php7-gd \
      php7-gettext \
      php7-iconv \
      php7-imagick \
      php7-imap \
      php7-intl \
      php7-json \
      php7-mbstring \
      php7-mcrypt \
      php7-memcached \
      php7-mysqli \
      php7-opcache \
      php7-openssl \
      php7-pdo \
      php7-pdo_mysql \
      php7-pdo_pgsql \
      php7-phar \
      php7-posix \
      php7-redis \
      php7-shmop \
      php7-sysvmsg \
      php7-sysvsem \
      php7-sysvshm \
      php7-simplexml \
      php7-soap \
      php7-sockets \
      php7-tokenizer \
      php7-wddx \
      php7-xml \
      php7-xmlreader \
      php7-xmlwriter \
      php7-xsl \
      php7-zip \
      php7-zlib && \
    rm -rf /var/cache/apk/* && \
    cd /tmp && \
    ln -sf /usr/bin/php7 /usr/bin/php && \
    COMPOSER_HASH=$(curl -sS https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Install drush and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/drush$DRUSH_VERSION \
      composer global require drush/drush:$DRUSH_RELEASE && \
    cd / && \
    ln -sf /usr/local/drush$DRUSH_VERSION/vendor/bin/drush /usr/bin/drush && \
    drush status && \
    # Install registry_rebuild to the appuser's homedir.
    drush -y @none dl --destination=/home/appuser/.drush/commands registry_rebuild-7.x && \
    # Ensure the appuser's drush directory is writable.
    chown -R appuser:appuser /home/appuser/.drush && \
    # Symlink the appuser's drush module to root's.
    mkdir -p /root/.drush && \
    ln -s /home/appuser/.drush/commands /root/.drush/commands && \
    # Add our default drushrc.php file.
    mkdir -p /etc/drush && \
    mv /drushrc.php /etc/drush/drushrc.php && \
    # Cleanup.
    rm -f /tmp/drush8-2282.patch /tmp/drush8-2567.patch && \
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
    mkdir /opt && \
    unzip /tmp/casperjs.zip -d /opt && \
    mv /opt/casperjs-master /opt/casperjs && \
    ln -s /opt/casperjs/bin/casperjs /usr/local/bin/casperjs && \
    rm -f /tmp/casperjs.zip && \
    # Found an actual working PhantomJS at http://fabiorehm.com/blog/2015/07/22/building-a-minimum-viable-phantomjs-2-docker-image
    # It's a year old, but it's newer than the old one (1.9.8) and it works.
    # Mind you, only extract part of the archive, or our crafted passwd and shadow files wil be overwritten.
    curl -Ls https://github.com/fgrehm/docker-phantomjs2/releases/download/v2.0.0-20150722/dockerized-phantomjs.tar.gz \
      | tar xz -C / bin etc/fonts etc/ssl lib lib64 usr/lib usr/local usr/share

WORKDIR /tmp

CMD ["bash"]
