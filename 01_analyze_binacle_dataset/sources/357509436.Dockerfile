FROM iamluc/symfony

MAINTAINER Luc Vieillescazes <luc@vieillescazes.net>

COPY . ./

RUN rm index.html \
  && composer install --no-interaction --no-dev --no-scripts \
  && rm -Rf var/cache/* var/logs/* .composer web/app_dev.php web/config.php \
  && mkdir /data \
  && chown www-data:www-data var/cache var/logs /data

COPY docker/build/entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/data"]

ENV SYMFONY_ENV prod
ENV DK_STORAGE_PATH /data
ENV DK_JWT_KEY_PASS_PHRASE DunkerqueIsOnFire
