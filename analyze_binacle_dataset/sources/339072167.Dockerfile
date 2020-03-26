FROM debian:stretch-slim

ARG VERSION
ENV VERSION=$VERSION

ARG ARCH

RUN mkdir -p /opt
RUN cd /opt/ \
    && apt-get update -q \
    && apt-get install -q -y --no-install-recommends ca-certificates curl \
    && curl -Lskj https://github.com/justwatchcom/elasticsearch_exporter/releases/download/v${VERSION}/elasticsearch_exporter-${VERSION}.linux-$ARCH.tar.gz -o elasticsearch_exporter-${VERSION}.tar.gz \
    && tar zxvf elasticsearch_exporter-${VERSION}.tar.gz \
    && rm elasticsearch_exporter-${VERSION}.tar.gz \
    && mv elasticsearch_exporter-${VERSION}.linux-$ARCH/elasticsearch_exporter /bin \
    && mkdir -p /var/lib/cerebro/ \
    && rm -rf /tmp/* \
    && apt-get autoremove --purge -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE      9108
ENTRYPOINT  [ "/bin/elasticsearch_exporter" ]

