FROM php:7.0-fpm

RUN  apt-get update \
  && apt-get install -y libfcgi0ldbl supervisor \
  && rm -rf /var/lib/apt/lists/*

COPY ./src /src

COPY fcgi-status-script.sh /usr/local/bin/
COPY start-status-server.sh /usr/local/bin/
COPY index.php /var/www/html/metrics/index.php

COPY php-fpm.conf /usr/local/etc/php-fpm.conf
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
