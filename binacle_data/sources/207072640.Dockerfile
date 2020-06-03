FROM unocha/alpine-base-php-fpm:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="php-fpm-wordpress" \
      org.label-schema.description="This service provides a php-fpm platform for WordPress." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF

RUN apk add --update-cache \
        php7-mysqli && \
    rm -rf /var/cache/apk/*

# Volumes
# - Conf: /etc/php7/ (php.ini, php-fpm.conf, conf.d/)
# - Logs: /var/log/php
# - Data: /srv/www, /var/lib/php/session
