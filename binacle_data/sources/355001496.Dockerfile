FROM gabesullice/drocker-php-fpm

ADD https://ftp.drupal.org/files/projects/drupal-8.2.7.tar.gz /tmp/drupal.tar.gz

RUN mkdir -p /opt/drupal \
    && tar -xvz -C /opt/drupal -f /tmp/drupal.tar.gz \
    && rm -rf /var/www/html \
    && mv /opt/drupal/drupal-* /var/www/html \
    && chown -R root:www-data /var/www/html \
    && find /var/www/html -type f -exec chmod 744 {} \; \
    && find /var/www/html -type d -exec chmod 755 {} \;

WORKDIR /var/www/html

# Install composer
ADD https://getcomposer.org/installer /tmp/composer-setup.php
RUN php /tmp/composer-setup.php --filename=composer --install-dir=/usr/local/bin \
    && rm /tmp/composer-setup.php

# Update drupal packages
RUN /usr/local/bin/composer update --no-dev -vvv
