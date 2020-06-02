ARG ES_VERSION=6.5.1

FROM debian:stretch-slim AS build
LABEL maintainer="Petar Obradović <spideyfusion@gmail.com>"

RUN apt-get update && \
    apt-get install -y zip unzip

COPY . context/

RUN cd context && \
    script/build.sh \
    mkdir .build/dist && \
    unzip -d .build/dist .build/package.zip

FROM docker.elastic.co/elasticsearch/elasticsearch:${ES_VERSION}

COPY --chown=elasticsearch:elasticsearch --from=build /context/.build/dist/ /usr/share/elasticsearch/config/hunspell/hr_HR/
