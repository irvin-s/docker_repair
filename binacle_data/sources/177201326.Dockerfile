# Dockerfile for distribution of purkinje application.
# This image is intended to be built inside
# the purkinje_dev environment.
# A separate image is used to avoid bloat from development tools.

FROM python:2.7-alpine
MAINTAINER Bernhard Biskup <bbiskup@gmx.de>

WORKDIR /code
COPY ./dist /code/dist

RUN apk add --update \
        python \
        python-dev \
        py-pip \
        py-cffi \
        build-base \
    && rm -rf /var/cache/apk/* \
    && pip install dist/purkinje-*.tar.gz \
    && apk del build-base python-dev

COPY purkinje.docker.yml /code/purkinje.yml

EXPOSE 5000

ENTRYPOINT ["purkinje", "-c", "purkinje.yml"]

