FROM       python:2.7-alpine
MAINTAINER Alex Banna alexb@tune.com
ENV        REFRESHED_AT 2016-01-22

ADD ./ /var/tune/freight_forwarder

WORKDIR /var/tune/freight_forwarder/docs

RUN set -ex && \
    apk add --no-cache --virtual .build-deps make gcc libc-dev linux-headers && \
    pip install -r requirements.txt && \
    make html && \
    apk del .build-deps


VOLUME ["/var/tune/freight_forwarder/docs/_build/html"]
