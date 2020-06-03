FROM zeroboh/php:7.1-fpm-alpine

COPY ./docker-php-entrypoint /docker-php-entrypoint
COPY ./docker-entrypoints /docker-entrypoints

RUN chmod +x /docker-php-entrypoint && chmod +x -R /docker-entrypoints

ENTRYPOINT ["/docker-php-entrypoint"]

CMD ["php-fpm"]