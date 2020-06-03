FROM php:7-apache

SHELL ["/bin/bash", "-c"]

# Enable PDO, PDO_MySQL extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install the Composer
RUN set -eux \
    && apt-get update \
    && apt-get install --no-install-recommends -y wget mc \
    && rm -r /var/lib/apt/lists/* \
    && EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');") \
    && SIGNATURE_VERIFIED=$(php -r "echo ('${ACTUAL_SIGNATURE}' === '${EXPECTED_SIGNATURE}');") \
    && if [[ "$SIGNATURE_VERIFIED" == "1" ]]; then \
         php composer-setup.php --quiet; \
       fi; \
       rm composer-setup.php
