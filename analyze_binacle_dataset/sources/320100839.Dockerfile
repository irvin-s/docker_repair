FROM php:5.6-alpine

MAINTAINER TAMURA Yoshiya <a@qmu.jp>

RUN apk --no-cache add --virtual build-dependencies graphviz \
    && pear channel-discover pear.phpdoc.org \
    && pear install phpdoc/phpDocumentor \
    && apk del --purge -r build-dependencies

WORKDIR /src
