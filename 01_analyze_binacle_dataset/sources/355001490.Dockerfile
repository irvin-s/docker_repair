FROM gabesullice/drocker-drupal-cli

USER root

RUN /bin/sh -c 'echo "date.timezone = America/Denver" > /usr/local/etc/php/conf.d/timezone.ini'

RUN mkdir -p /opt/drupalextension

COPY composer.json /opt/drupalextension/composer.json

RUN cd /opt/drupalextension \
      && composer install -vvv \
      && ln -s /opt/drupalextension/bin/behat /usr/local/bin/behat

ENTRYPOINT ["/usr/local/bin/php", "./core/scripts/run-tests.sh", "--php", "/usr/local/bin/php"]
