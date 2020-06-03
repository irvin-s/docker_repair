FROM unocha/base-php5:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humaitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="php5" \
      org.label-schema.description="This service provides a php-fpm platform with drush and composer." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

ENV DRUSH_VERSION=6 \
    DRUSH_RELEASE=6.7.0

COPY drushrc.php /

RUN apk add --update-cache \
      php5-cli \
      mysql-client \
      postgresql-client  && \
    rm -rf /var/cache/apk/* && \
    # Symlink php5 binary.
    ln -sf /usr/bin/php5 /usr/bin/php && \
    # Set unlimited memory for CLI php.
    sed -i 's/^memory_limit = .*/memory_limit = -1/' /etc/php5/php.ini && \
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
    ln -sf /usr/local/drush$DRUSH_VERSION/vendor/bin/drush /usr/bin/drush && \
    # Patch drush to stop the "4 byte UTF-8 for mysql" warning on updb.
    # See https://github.com/drush-ops/drush/issues/2270
    sed -i 's/!= REQUIREMENT_OK/>= REQUIREMENT_OK/' \
      /usr/local/drush$DRUSH_VERSION/vendor/drush/drush/commands/core/drupal/update_7.inc && \
    drush status && \
    # Install registry_rebuild to the appuser's homedir.
    drush -y @none dl --destination=/home/appuser/.drush/commands registry_rebuild && \
    # Ensure the appuser's drush directory is writable.
    chown -R appuser:appuser /home/appuser/.drush && \
    # Symlink the appuser's drush module to root's.
    mkdir -p /root/.drush && \
    ln -s /home/appuser/.drush/commands /root/.drush/commands && \
    # Add our default drushrc.php file.
    mkdir -p /etc/drush && \
    mv /drushrc.php /etc/drush/drushrc.php


# Volumes
# - Conf: /etc/php5/ (php.ini, php-fpm.conf, conf.d/)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
