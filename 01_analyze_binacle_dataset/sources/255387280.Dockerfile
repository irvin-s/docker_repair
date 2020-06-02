FROM alpine:latest
#FROM docker-hub.2gis.ru/2gis/nodejs:6.9
#FROM docker-hub.2gis.ru/2gis/java:8

MAINTAINER ci-starter-kit developers "k.sidenko@2gis.ru"

RUN set -ex \
    && apk add --no-cache \
        curl \
        bash \
        make

ARG BUILD_PATH=bin
ARG SOURCE_PATH
ARG PORT=5000
ARG HEALTHCHECK=/healthcheck

WORKDIR ${SOURCE_PATH}

COPY ./${BUILD_PATH} ./${BUILD_PATH}

COPY Makefile ./

EXPOSE ${PORT}

HEALTHCHECK --interval=5s --timeout=10s --retries=3 \
    CMD curl --fail http://localhost:${PORT}${HEALTHCHECK} || exit 1

ENTRYPOINT ["bash", "-c"]

CMD ["make run"]
