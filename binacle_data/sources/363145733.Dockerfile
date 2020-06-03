FROM webplates/symfony-php-dev:7.0-fpm

ARG USE_XDEBUG=no

RUN if [ $USE_XDEBUG = "yes" ]; then docker-php-ext-enable xdebug; fi

COPY php.ini /usr/local/etc/php/conf.d/custom.ini
COPY entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
