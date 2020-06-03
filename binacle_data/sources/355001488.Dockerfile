FROM gabesullice/drocker-php-fpm

RUN apk add --no-cache \
      mysql-client

RUN ln -sf /home/drupal-cli/bin/composer /usr/local/bin/composer \
      && ln -sf /home/drupal-cli/bin/drupal /usr/local/bin/drupal \
      && ln -sf /home/drupal-cli/bin/drush /usr/local/bin/drush

RUN adduser -D -h /home/drupal-cli drupal-cli
USER drupal-cli

# Install composer
RUN curl -Ss https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN mkdir -p /home/drupal-cli/bin && php /tmp/composer-setup.php --filename=composer --install-dir=/home/drupal-cli/bin \
    && rm /tmp/composer-setup.php

# Install drush
RUN curl -Ss http://files.drush.org/drush.phar -o /tmp/drush.phar \
      && php /tmp/drush.phar core-status \
      && chmod +x /tmp/drush.phar \
      && mv /tmp/drush.phar /home/drupal-cli/bin/drush \
      && drush init -y

RUN curl https://drupalconsole.com/installer -L -o /tmp/drupal.phar \
      && chmod +x /tmp/drupal.phar \
      && mv /tmp/drupal.phar /home/drupal-cli/bin/drupal \
      && drupal self-update

WORKDIR /var/www/web
