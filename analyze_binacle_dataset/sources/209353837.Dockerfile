FROM python:3.6.4-alpine

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

RUN pip install --upgrade \
    setuptools \
    pip \
    wheel \
    pipenv

WORKDIR /etools/
ADD Pipfile .
ADD Pipfile.lock .
RUN pipenv install --dev --system  --ignore-pipfile
RUN apk add bash

ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /code
ENV DJANGO_SETTINGS_MODULE etools.config.settings.local

VOLUME "./:/code/"
WORKDIR /code/
