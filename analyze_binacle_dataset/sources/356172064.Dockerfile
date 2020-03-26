FROM openjdk:8-jdk-alpine3.9

LABEL Description="This image is used to start the yona" maintainer="pokev25"

ARG YONA_VERSION=1.12.0
ARG YONA_BIN=yona-v${YONA_VERSION}-bin.zip
ARG YONA_DOWNLOAD_URL=https://github.com/yona-projects/yona/releases/download/v${YONA_VERSION}/${YONA_BIN}

## install package
RUN apk add --no-cache unzip bash tzdata

## Timezone
ENV TZ Asia/Seoul

## make work directory
RUN mkdir -p /yona/downloads

## install yona
RUN cd /yona/downloads && \
    wget --no-check-certificate $YONA_DOWNLOAD_URL && \
    unzip -d /yona/release ${YONA_BIN} && \
    mv /yona/release/yona-$YONA_VERSION /yona/release/yona && \
    rm -f ${YONA_BIN}

## set environment variables
ENV YONA_DATA "/yona/data"
ENV JAVA_OPTS "-Xmx2048m -Xms1024m"

## add entrypoints
ADD ./entrypoints /yona/entrypoints
RUN chmod +x /yona/entrypoints/*.sh

## yona home directory mount point from host to docker container
VOLUME /yona/data
WORKDIR /yona

## yona service port expose from docker container to host
EXPOSE 9000

## run yona command
ENTRYPOINT ["/yona/entrypoints/bootstrap.sh"]
