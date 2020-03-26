FROM alpine:3.7
LABEL maintainer "gavin zhou <gavin.zhou@gmail.com>"

ENV GRAFANA_VERSION=4.6.3 \
 GLIBC_VERSION=2.26-r0 \
  GOSU_VERSION=1.10

RUN set -ex \
    && addgroup -S grafana \
    && adduser -S -G grafana grafana \
    && apk add --no-cache ca-certificates openssl fontconfig bash curl \
    && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community dumb-init \
    && curl -sL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64 > /usr/sbin/gosu \
    && chmod +x /usr/sbin/gosu  \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && apk add glibc-${GLIBC_VERSION}.apk \
    && wget https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana-${GRAFANA_VERSION}.linux-x64.tar.gz \
    && tar -xzf grafana-$GRAFANA_VERSION.linux-x64.tar.gz \
    && mv grafana-$GRAFANA_VERSION/ grafana/ \
    && mv grafana/bin/* /usr/local/bin/ \
    && mkdir -p /grafana/{dashboards,data,logs,plugins} \
    && mkdir /var/lib/grafana/ \
    && ln -s /grafana/plugins /var/lib/grafana/plugins \
    && grafana-cli plugins update-all \
    && rm -f grafana/conf/*.ini \
    && rm grafana-$GRAFANA_VERSION.linux-x64.tar.gz /etc/apk/keys/sgerrand.rsa.pub glibc-${GLIBC_VERSION}.apk \
    && chown -R grafana:grafana /grafana \
    && apk del curl

VOLUME  ["/grafana"]
COPY ./defaults.ini /grafana/conf/
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 3000   

ENTRYPOINT ["/docker-entrypoint.sh"]