FROM unocha/php7:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <docker+ops@humanitarianresponse.info>

# A little bit of metadata management.
ARG BUILD_DATE
ARG VERSION
ARG VCS_URL
ARG VCS_REF

# Tell Puppeteer to skip installing Chrome. We'll be connected to a chrome
# instance in another container via websockets.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
# Puppeteer v0.13.0 works with Chromium 64.
ENV PUPPETEER_VERSION 1.5.0

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="php7-puppeteer" \
      org.label-schema.description="This service provides a php-fpm platform for the FTS Public and HPC Viewer Drupal sites." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm ftp gd gettext iconv igbinary imagick imap intl json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop soap sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm" \
      info.humanitarianresponse.puppeteer=$PUPPETEER_VERSION

RUN echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://dl-cdn.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --update nodejs nodejs-npm && \
    npm install --save puppeteer@$PUPPETEER_VERSION request request-promise-native options-parser util && \
    # Clean up.
    rm -f package-lock.json && \
    rm -rf /var/cache/apk/*
