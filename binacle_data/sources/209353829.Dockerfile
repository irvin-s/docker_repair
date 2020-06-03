FROM python:3.6.4-alpine
# test-base-p3-v2
RUN echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update
RUN apk add --upgrade apk-tools

RUN apk add \
    --update alpine-sdk

RUN apk add openssl \
    ca-certificates \
    libressl2.7-libcrypto
RUN apk add \
    libxml2-dev \
    libxslt-dev \
    xmlsec-dev
RUN apk add postgresql-dev \
    libffi-dev\
    jpeg-dev

RUN apk add --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    gdal \
    gdal-dev \
    py-gdal \
    geos \
    geos-dev \
    gcc \
    g++

RUN apk add bash

RUN pip install --upgrade \
    setuptools \
    pip \
    wheel \
    pipenv \
    tox

