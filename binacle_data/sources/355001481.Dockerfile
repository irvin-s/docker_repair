FROM gabesullice/drocker-drupal-8:8.2

RUN ln -sf /var/www/files /var/www/html/sites/default/files
RUN ln -sf /var/www/settings/settings.local.php /var/www/html/sites/default/settings.local.php

COPY ./docroot/sites/default/settings.php /var/www/html/sites/default/settings.php

COPY ./docroot/themes /var/www/html/themes
COPY ./docroot/modules /var/www/html/modules
COPY ./config /var/www/config

VOLUME /var/www/html
VOLUME /var/www/files
