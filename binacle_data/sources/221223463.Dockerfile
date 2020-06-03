ARG image_tag=latest
FROM pinterb/jq:0.0.16 AS jq
FROM elifesciences/proofreader-php:0.2 AS proofreader
FROM elifesciences/journal_composer_dev:${image_tag} AS composer
FROM elifesciences/journal:${image_tag}

USER root
RUN mkdir -p build/ci var/fixtures && \
    touch .php_cs.cache && \
    chown --recursive www-data:www-data build/ci .php_cs.cache var/fixtures

COPY --from=jq /usr/local/bin/jq /usr/bin/jq

COPY --from=proofreader --chown=elife:elife /srv/proofreader-php /srv/proofreader-php
RUN ln -s /srv/proofreader-php/bin/proofreader /srv/bin/proofreader

COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY --chown=elife:elife \
    behat.yml.dist \
    phpunit.xml.dist \
    .php_cs \
    ./
COPY --chown=elife:elife .ci/ .ci/
COPY --chown=elife:elife assets/tests/ assets/tests/
COPY --chown=elife:elife composer.json composer.lock ./
COPY --from=composer --chown=elife:elife /app/vendor/ vendor/
COPY --chown=elife:elife features/ features/
COPY --chown=elife:elife test/ test/

USER www-data
