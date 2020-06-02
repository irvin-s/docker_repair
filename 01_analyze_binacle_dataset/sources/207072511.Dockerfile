FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# Parse arguments for the build command.
ARG UPSTREAM
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
      org.label-schema.name="base-php" \
      org.label-schema.description="This service provides a base php-fpm platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="$UPSTREAM" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm gd gettext iconv imagick intl json mcrypt memcached mysqli opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm"

# Default PHP configuration variables. These can be overridden via the environment.
ENV PHP_RUN_USER=appuser \
    PHP_RUN_GROUP=appuser \
    PHP_MAX_CHILDREN=16 \
    PHP_START_SERVERS=2 \
    PHP_MIN_SPARE_SERVERS=1 \
    PHP_MAX_SPARE_SERVERS=2 \
    PHP_MAX_REQUESTS=1000 \
    PHP_MEMORY_LIMIT=256M \
    PHP_MAX_EXECUTION_TIME=60s \
    PHP_POST_MAX_SIZE=100m \
    PHP_UPLOAD_MAX_FILESIZE=100m

COPY etc/php7 etc/services/run_fpm etc/msmtprc /

RUN \
    # Install standard packages from $UPSTREAM.
    apk -U upgrade && \
    apk add --update-cache \
      fcgi \
      imagemagick \
      msmtp \
      php7-bcmath \
      php7-bz2 \
      php7-calendar \
      php7-ctype \
      php7-curl \
      php7-dom \
      php7-exif \
      php7-iconv \
      php7-fileinfo \
      php7-fpm \
      php7-gd \
      php7-gettext \
      php7-iconv \
      php7-imagick \
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
    \
    # Setup directory structure for FPM.
    mkdir -p /etc/services.d/fpm /srv/www/html && \
    mv /msmtprc /etc/msmtprc && \
    mv /run_fpm /etc/services.d/fpm/run && \
    \
    # Fixup the sendmail path for msmtp and set it as mailer.
    ln -sf /usr/bin/msmtp /usr/sbin/sendmail && \
    ln -sf /usr/bin/msmtp /usr/bin/sendmail && \
    \
    # Configure php.
    rm -rf /etc/php7 && \
    mkdir -p /etc/php7 && \
    mv -f /php.ini /conf.d /php-fpm.conf /php-fpm.d /etc/php7 && \
    \
    # Configure PHP logs.
    rm -rf /var/log/php7 && \
    mkdir /var/log/php && \
    touch /var/log/php/www-error.log && \
    touch /var/log/php/www-slow.log

EXPOSE 9000

# Add a health check for the FPM server on port 9000.
HEALTHCHECK --interval=60s --timeout=5s \
        CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000
