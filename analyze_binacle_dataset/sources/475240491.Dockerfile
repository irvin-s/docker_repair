
# Run composer in a container.
#
# docker run --rm -it \
#    -v $(pwd):/usr/src/app \
#    -v ~/.composer:/home/composer/.composer \
#    -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
#    graze/composer:php-7.0

FROM alpine:3.5

LABEL maintainer="developers@graze.com" \
    license="MIT" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="graze" \
    org.label-schema.name="composer" \
    org.label-schema.description="alpine composer image" \
    org.label-schema.vcs-url="https://github.com/graze/docker-composer"

RUN apk add --no-cache \
    ca-certificates \
    git \
    mercurial \
    openssh-client \
    subversion \
    php7 \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-phar \
    php7-posix \
    php7-zlib

RUN ln -s /usr/bin/php7 /usr/bin/php

ARG COMPOSER_VER
ENV COMPOSER_VER ${COMPOSER_VER:-1.5.1}

RUN php -r "readfile('https://getcomposer.org/installer');" | \
    php -- --install-dir /usr/local/bin --filename composer --version ${COMPOSER_VER} && \
    mkdir -p /home/composer/.composer && \
    ln -s /root/.ssh /home/composer/.ssh

LABEL org.label-schema.version="${COMPOSER_VER}-php7.0"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/composer/.composer

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/usr/src/app -v ~/.composer:/home/composer/.composer -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro graze/composer:${COMPOSER_VER}-php7.0"

WORKDIR /usr/src/app

VOLUME ["/home/composer/.composer"]

ENTRYPOINT ["/usr/bin/php", "/usr/local/bin/composer"]
