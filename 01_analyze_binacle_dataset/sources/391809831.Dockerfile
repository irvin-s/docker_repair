FROM php:7.3-cli-stretch as php-builder

WORKDIR /workspace

RUN apt-get update && apt-get install git unzip -y --no-install-recommends \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

RUN git clone https://github.com/ConnectedGames/MCMirror.git . \
    && composer install

FROM kkarczmarczyk/node-yarn as yarn-builder

WORKDIR /workspace

COPY --from=php-builder /workspace /workspace

RUN yarn install && yarn encore production && rm -rf node_modules

FROM php:7.3-cli-alpine

WORKDIR /workspace

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" && docker-php-ext-install -j$(nproc) pcntl

COPY --from=yarn-builder /workspace /workspace

EXPOSE 80

ENTRYPOINT ["/bin/sh", "/workspace/docker/run.sh"]