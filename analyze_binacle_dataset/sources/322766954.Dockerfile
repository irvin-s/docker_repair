FROM wearejh/m2-php-70:travis-14

# Magento
COPY composer.json composer.lock ./
#COPY .docker/composer-cache .docker/composer-cache

RUN chsh -s /bin/bash www-data \
    && chown -R www-data:www-data ./

RUN su - www-data -c "COMPOSER_CACHE_DIR=.docker/composer-cache composer install --no-interaction --prefer-dist -o"

# Frontend
COPY app app
COPY bin bin
COPY dev dev
COPY generated generated
COPY lib lib
COPY pub pub
COPY setup setup
COPY var var

RUN find . -user root | xargs chown www-data:www-data

VOLUME ["/var/www/app/etc"]
VOLUME ["/var/www/pub"]
VOLUME ["/var/www/setup"]
VOLUME ["/var/www/var"]
VOLUME ["/var/www/vendor"]
VOLUME ["/var/www/lib"]

ENTRYPOINT ["/usr/local/bin/docker-configure"]
CMD ["php-fpm"]
