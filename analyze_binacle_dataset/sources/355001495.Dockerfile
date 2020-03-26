FROM gabesullice/drocker-php-fpm

ADD https://ftp.drupal.org/files/projects/drupal-7.44.tar.gz /opt/drupal.tar.gz

RUN mkdir -p /opt/drupal \
    && tar -xvz -C /opt/drupal -f /opt/drupal.tar.gz \
    && rm -rf /var/www/html \
    && mv /opt/drupal/drupal-* /var/www/html \
    && chown -R root:www-data /var/www/html \
    && find /var/www/html -type f -exec chmod 744 {} \; \
    && find /var/www/html -type d -exec chmod 755 {} \;

WORKDIR /var/www/html
