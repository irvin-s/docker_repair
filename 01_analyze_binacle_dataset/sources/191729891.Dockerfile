FROM jakzal/phpqa:alpine

RUN set -xe \
    && apk add --update openssl ca-certificates \
    && apk add --no-cache --virtual .php-deps \
        libsodium \
        libpq \
        icu-libs \
        postgresql-client \
        git \
    && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        postgresql-dev \
        libsodium-dev \
        icu-dev  \
    && docker-php-ext-install \
        pdo_pgsql \
        pgsql \
        bcmath \
        intl \
        sodium \
    && pecl install apcu \
    && pecl install redis-3.1.2 \
    \
    && docker-php-ext-enable apcu redis sodium \
    && { find /usr/local/lib -type f -print0 | xargs -0r  --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/*

COPY qa/tools.json $TOOLBOX_TARGET_DIR/extra-tools.json

RUN php $TOOLBOX_TARGET_DIR/toolbox install --tools $TOOLBOX_TARGET_DIR/extra-tools.json \
  && rm -rf ~/.composer/cache

ENV TOOLBOX_JSON="phar://$TOOLBOX_TARGET_DIR/toolbox/resources/pre-installation.json,phar://$TOOLBOX_TARGET_DIR/toolbox/resources/tools.json,$TOOLBOX_TARGET_DIR/extra-tools.json"
