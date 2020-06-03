FROM python:3.6.4-alpine as builder

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
    libffi-dev \
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
RUN pipenv install --system  --ignore-pipfile --deploy


FROM python:3.6.4-alpine

RUN echo "http://dl-3.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories
RUN apk update
RUN apk add --upgrade apk-tools
RUN apk add postgresql-client
RUN apk add openssl \
    ca-certificates \
    libressl2.7-libcrypto \
    libmagic \
    libxslt

RUN apk add geos \
    gdal --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

ADD src /code/
ADD manage.py /code/manage.py

WORKDIR /code/

COPY --from=builder /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /code
ENV DJANGO_SETTINGS_MODULE etools.config.settings.production
RUN SECRET_KEY=not-so-secret-key-just-for-collectstatic DISABLE_JWT_LOGIN=1 python manage.py collectstatic --noinput
