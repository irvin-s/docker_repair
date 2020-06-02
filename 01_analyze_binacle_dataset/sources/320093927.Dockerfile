FROM alpine:3.2
MAINTAINER Dave Wittman <dave@objectrocket.com>

ENV KIBANA_VERSION 4.4.0-linux-x64

RUN apk add --update nodejs curl && \
    mkdir /opt && \
    ln -sf /opt/kibana-${KIBANA_VERSION} /opt/kibana && \
    curl -sL https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz | tar xz -C /opt && \
    rm -rf /opt/kibana/node && \
    mkdir -p /opt/kibana/node/bin && \
    ln -sf /usr/bin/node /opt/kibana/node/bin/node && \
    apk del curl && \
    rm -rf /var/cache/apk/*

ADD ./run.sh /opt/kibana/

EXPOSE 5601

ENTRYPOINT ["/opt/kibana/run.sh"]
