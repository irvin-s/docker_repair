FROM unocha/alpine-base:%%UPSTREAM%%
MAINTAINER orakili <docker@orakili.net>

# Alpine based docker image.
# Includes php composer, ruby bundler and drush.

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV DRUSH_VERSION=6 \
    DRUSH_RELEASE=6.7.0

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-php-builder" \
      org.label-schema.description="This service provides a PHP builder platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.7" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 ctype curl dom fpm gd iconv imagick json mcrypt mysql opcache openssl pdo pdo_mysql pdo_pgsql phar posix sockets xml xmlreader zip zlib" \
      info.humanitarianresponse.php.sapi="cli" \
      info.humanitarianresponse.drush=$DRUSH_RELEASE

RUN apk add --update-cache \
      bash \
      ca-certificates \
      curl \
      git \
      gzip \
      openssh-client \
      patch \
      rsync \
      tar \
      wget \
      php5-bcmath \
      php5-cli \
      php5-ctype \
      php5-curl \
      php5-dom \
      php5-fpm \
      php5-gd \
      php5-iconv \
      php5-json \
      php5-mcrypt \
      php5-posix \
      php5-opcache \
      php5-openssl \
      php5-pdo \
      php5-phar \
      php5-sockets \
      php5-zip \
      php5-zlib \
      php5-xml \
      php5-xmlreader \
      ruby-bundler \
      ruby-io-console \
      ruby-rdoc \
      ruby-json && \
    rm -rf /var/cache/apk/* && \
    cd /tmp && \
    ln -sf /usr/bin/php5 /usr/bin/php && \
    COMPOSER_HASH=$(curl -sS https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '$COMPOSER_HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');" && \
    # Install drush and symlink it somewhere useful.
    COMPOSER_HOME=/usr/local/drush$DRUSH_VERSION \
    composer global require drush/drush:$DRUSH_RELEASE && \
    ln -sf /usr/local/drush$DRUSH_VERSION/vendor/bin/drush /usr/bin/drush && \
    sed -i 's/!= REQUIREMENT_OK/>= REQUIREMENT_OK/' \
      /usr/local/drush$DRUSH_VERSION/vendor/drush/drush/commands/core/drupal/update_7.inc && \
    drush status

WORKDIR /tmp

CMD ["bash"]
