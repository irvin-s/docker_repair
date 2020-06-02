FROM gabesullice/drocker-drupal-cli

USER root

RUN /bin/sh -c 'echo "date.timezone = America/Denver" > /usr/local/etc/php/conf.d/timezone.ini'

ENTRYPOINT ["/usr/local/bin/php", "./core/scripts/run-tests.sh", "--php", "/usr/local/bin/php"]
