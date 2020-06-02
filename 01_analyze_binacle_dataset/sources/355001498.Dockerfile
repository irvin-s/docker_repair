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

# Install drupal console
RUN curl -Ss https://drupalconsole.com/installer -o /tmp/drupal.phar \
    && php /tmp/drupal.phar \
    && mv /tmp/drupal.phar /home/drupal-cli/bin/drupal \
    && chmod +x /home/drupal-cli/bin/drupal \
    && drupal init --override \
    && sed -i /mysql/d /home/drupal-cli/.console/phpcheck.yml

# Install drupal code sniffers
RUN composer global require drupal/coder \
  && /bin/sh -c 'printf "export PATH=$PATH:/home/drupal-cli/.composer/vendor/bin" >> /home/drupal-cli/.profile'
RUN /home/drupal-cli/.composer/vendor/bin/phpcs --config-set installed_paths /home/drupal-cli/.composer/vendor/drupal/coder/coder_sniffer

WORKDIR /var/www/html
