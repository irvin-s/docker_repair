ARG image_tag=latest
ARG node_version
FROM elifesciences/journal_composer:${image_tag} AS composer
FROM elifesciences/journal_npm:${image_tag} as npm
FROM node:${node_version}

COPY --from=npm /node_modules/ node_modules/

COPY assets/images/ assets/images/
COPY gulpfile.js ./
COPY --from=composer /app/vendor/elife/patterns/resources/assets/ vendor/elife/patterns/resources/assets/

RUN node_modules/.bin/gulp assets
