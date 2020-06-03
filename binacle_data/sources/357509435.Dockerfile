FROM iamluc/symfony

MAINTAINER Luc Vieillescazes <luc@vieillescazes.net>

RUN rm index.html \
  && wget -O - https://github.com/iamluc/dunkerque/archive/master.tar.gz | tar xz --strip 1 \
  && composer install --no-interaction --no-dev --no-scripts \
  && rm -Rf var/cache/* var/logs/* .composer web/app_dev.php web/config.php \
  && mkdir /data \
  && chown www-data:www-data var/cache var/logs /data

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

VOLUME ["/data"]

ENV SYMFONY_ENV prod
ENV DK_STORAGE_PATH /data
ENV DK_JWT_KEY_PASS_PHRASE DunkerqueIsOnFire
