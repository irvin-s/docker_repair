FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

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
      org.label-schema.name="base-php" \
      org.label-schema.description="This service provides a base php-fpm platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 ctype curl dom fpm gd iconv imagick json mcrypt mysql opcache openssl pdo pdo_mysql pdo_pgsql phar posix sockets xml xmlreader zip zlib memcached redis" \
      info.humanitarianresponse.php.sapi="fpm"

COPY php-fpm.conf run_fpm msmtprc /
COPY APKBUILD-php5-imagick APKBUILD-php5-memcached APKBUILD-php5-redis abuild-root.patch /

RUN \
    # This needs to happen here, or the root user won't be in
    # the abuild group in the next command shell.
    adduser root abuild

RUN \
    # Install standard packages from 3.8.
    apk add --update-cache \
      fcgi \
      msmtp && \
    \
    # Install php build dependencies.
    apk add --virtual .build-dependencies \
      php5-dev alpine-sdk && \
    \
    # Patch abuild, so it will run as root.
    cd /usr/bin && \
      patch -p0 -i /abuild-root.patch && \
      rm -f /abuild-root.patch && \
    \
    # Add root to the abuild group and create abuild key.
    abuild-keygen -a -q -n && \
    \
    # Setup our build environments.
    mkdir -p /usr/src/php5-imagick && \
      mv /APKBUILD-php5-imagick /usr/src/php5-imagick/APKBUILD && \
    mkdir -p /usr/src/php5-memcached && \
      mv /APKBUILD-php5-memcached /usr/src/php5-memcached/APKBUILD && \
    mkdir -p /usr/src/php5-redis && \
      mv /APKBUILD-php5-redis /usr/src/php5-redis/APKBUILD
RUN \
    # Build the imagick extension. Delete the generated index, or the next
    # step will fail because our key is not trusted.
    cd /usr/src/php5-imagick && \
      abuild -F -r -P /usr && \
      rm -f /usr/src/x86_64/APKINDEX.tar.gz && \
    \
    # Build the memcached extension. Delete the generated index, or the next
    # step will fail because our key is not trusted.
    cd /usr/src/php5-memcached && \
      abuild -F -r -P /usr && \
      rm -f /usr/src/x86_64/APKINDEX.tar.gz && \
    \
    # Build the redis extension. Delete the generated index, or the next
    # step will fail because our key is not trusted.
    cd /usr/src/php5-redis && \
      abuild -F -r -P /usr && \
      rm -f /usr/src/x86_64/APKINDEX.tar.gz && \
    \
    # Install all built extensions.
    apk add -U --allow-untrusted /usr/src/x86_64/php5-*.apk && \
    \
    # Install php5-cli *specifically*.
    apk add --update-cache \
      php5-cli && \
    # Install constrib php packages and depends.
    apk add --update-cache \
      php5-bcmath \
      php5-bz2 \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-fpm \
      php5-gd \
      php5-iconv \
      php5-json \
      php5-mcrypt \
      php5-mysql \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-pdo_mysql \
      php5-pdo_pgsql \
      php5-phar \
      php5-posix \
      php5-sockets \
      php5-xml \
      php5-xmlreader \
      php5-zip \
      php5-zlib && \
    \
    # Build php5-imagick, php5-memcached and php5-redis from source.
    # Cleanup.
    apk del .build-dependencies && \
    rm -rf /root/.abuild && \
    rm -rf /usr/src/* && \
    rm -rf /var/cache/distfiles && \
    rm -rf /var/cache/apk/* && \
    \
    # Setup directory structure and configure FPM.
    mkdir -p /etc/services.d/fpm /srv/www/html && \
    mv /msmtprc /etc/msmtprc && \
    mv /run_fpm /etc/services.d/fpm/run && \
    mv /etc/php5/php-fpm.conf /etc/php5/php-fpm.conf.verbose && \
    mv /php-fpm.conf /etc/php5/php-fpm.conf && \
    \
    # Fixup the sendmail path for msmtp and set it as mailer.
    ln -sf /usr/bin/msmtp /usr/sbin/sendmail && \
    ln -sf /usr/bin/msmtp /usr/bin/sendmail && \
    \
    # Configure php.
    sed -i \
        -e "s/^expose_php.*/expose_php = Off/" \
        -e "s/^;date.timezone.*/date.timezone = UTC/" \
        -e "s/^memory_limit.*/memory_limit = -1/" \
        -e "s/^max_execution_time.*/max_execution_time = 300/" \
        -e "s/^post_max_size.*/post_max_size = 128M/" \
        -e "s/^upload_max_filesize.*/upload_max_filesize = 128M/" \
        -e "s/^;sendmail_path =/sendmail_path = \/usr\/sbin\/sendmail -t/" \
      /etc/php5/php.ini && \
    echo "error_log = \"/var/log/php/error.log\"" | tee -a /etc/php5/php.ini && \
    \
    # Configure PHP logs.
    rm -rf /var/log/php5 && \
    mkdir /var/log/php && \
    touch /var/log/php/error.log && \
    touch /var/log/php/www-error.log && \
    touch /var/log/php/www-slow.log

EXPOSE 9000

# Add a health check for the FPM server on port 9000.
HEALTHCHECK --interval=30s --timeout=5s \
        CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000

# Volumes
# - Conf: /etc/php/ (php-fpm.conf, php.ini)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
