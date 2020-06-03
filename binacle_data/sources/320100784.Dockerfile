FROM alpine:latest

MAINTAINER Peter Teich <mail@pteich.xyz>

ENV GOSU_VERSION 1.10
ENV DUMB_INIT_VERSION 1.2.0
ENV SUMMITDB_VERSION 0.4.0

RUN addgroup -S summitdb && adduser -S -G summitdb summitdb

RUN mkdir -p /opt

RUN set -x \
    && apk update && apk add --no-cache --virtual .deps \
        openssl \
        dpkg \
        ca-certificates \
    && update-ca-certificates \
    && cd /opt \
    && dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${dpkgArch}" \
    && wget -O /usr/local/bin/dumb-init "https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_${dpkgArch}" \
    && chmod +x /usr/local/bin/gosu \
    && chmod +x /usr/local/bin/dumb-init \
    && wget -O summitdb.tar.gz "https://github.com/tidwall/summitdb/releases/download/${SUMMITDB_VERSION}/summitdb-${SUMMITDB_VERSION}-linux-${dpkgArch}.tar.gz" \
    && tar xzvf summitdb.tar.gz \
    && rm -f summitdb.tar.gz \
    && mv summitdb-${SUMMITDB_VERSION}-linux-${dpkgArch} summitdb \
    && apk del .deps

RUN mkdir /data && chown summitdb:summitdb /data
VOLUME ["/data"]

EXPOSE 7481

WORKDIR /opt/summitdb

ENTRYPOINT ["dumb-init", "gosu", "summitdb", "./summitdb-server", "-dir=/data"]

CMD [""]
