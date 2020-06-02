FROM alpine:latest
#FROM docker-hub.2gis.ru/2gis/golang:dev-1.7.3
#FROM docker-hub.2gis.ru/2gis/nodejs:dev-6.9
#FROM docker-hub.2gis.ru/2gis/scala-sbt:2.11

MAINTAINER ci-starter-kit developers "k.sidenko@2gis.ru"

RUN set -ex \
    && apk add --no-cache \
        curl \
        bash \
        make

ARG SOURCE_PATH

WORKDIR ${SOURCE_PATH}

COPY . .
