FROM gabesullice/drocker-drupal-7

COPY ./docroot/sites /var/www/html/sites

RUN mkdir -p /var/www/html /var/www/private /var/www/settings /var/www/files \
      && chown -R root:www-data /var/www/html /var/www/private /var/www/settings \
      && find /var/www/html -type d -exec chmod 755 {} \+ \
      && find /var/www/files -type d -exec chmod 775 {} \+ \
      && find /var/www/private -type d -exec chmod 775 {} \+ \
      && find /var/www/html -type f -exec chmod 744 {} \+ \
      && find /var/www/files -type f -exec chmod 764 {} \+ \
      && find /var/www/private -type f -exec chmod 764 {} \+

RUN ln -sf ../../../settings/local-settings.inc /var/www/html/sites/default/local-settings.inc
RUN ln -sf ../../../files /var/www/html/sites/default/files

VOLUME /var/www/html
