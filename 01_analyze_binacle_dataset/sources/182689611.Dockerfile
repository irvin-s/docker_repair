FROM php:7.3-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql
COPY ["php.ini", "/usr/local/etc/php/conf.d/php.ini"]

EXPOSE 9000

CMD ["php-fpm"]
ENTRYPOINT ["docker-php-entrypoint"]