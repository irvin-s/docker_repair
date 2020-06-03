FROM unocha/base-php7:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV DRUSH_VERSION=8 \
    DRUSH_RELEASE=8.1.15 \
    WP_RELEASE=2.1.0 \
    PAGER=more

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="php7" \
      org.label-schema.description="This service provides a php-fpm platform with composer, drush and wp-cli." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm ftp gd gettext iconv igbinary imagick imap intl json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop soap sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm" \
      info.humanitarianresponse.composer="1.8.4" \
      info.humanitarianresponse.drush=$DRUSH_RELEASE \
      info.humanitarianresponse.wp=$WP_RELEASE

COPY etc/my.cnf.d/client.cnf /client.cnf
COPY drushrc.php /drushrc.php
COPY drush8-2282.patch /tmp/drush8-2282.patch
COPY drush8-2567.patch /tmp/drush8-2567.patch

RUN apk add --update-cache \
        git \
        php7 \
        mysql-client \
        postgresql-client && \
    rm -rf /var/cache/apk/* && \
    \
    # Configure the MySQL client library.
    mv -f /client.cnf /etc/my.cnf.d/client.cnf && \
    \
    # Install composer, as suggested by https://getcomposer.org/
    # and https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md
    COMPOSER_HASH=$(curl -sS https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Install drush and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/drush$DRUSH_VERSION \
      composer global require drush/drush:$DRUSH_RELEASE && \
    cd /usr/local/drush8/vendor/drush/drush && \
      patch -p1 -i /tmp/drush8-2282.patch && \
      patch -p1 -i /tmp/drush8-2567.patch && \
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
    # Install wp-cli and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/wp$WP_RELEASE  \
      composer global require wp-cli/wp-cli:$WP_RELEASE && \
    ln -sf /usr/local/wp$WP_RELEASE/vendor/wp-cli/wp-cli/bin/wp /usr/bin/wp && \
    wp --info
