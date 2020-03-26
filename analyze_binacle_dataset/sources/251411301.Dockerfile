FROM alpine:3.4

# install dependencies
RUN apk add --no-cache curl nodejs rsyslog supervisor \
    && npm install -g json2yaml merge-yaml js-yaml lodash.merge \
    && curl -L -o /usr/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
    && chmod +x /usr/bin/jq \
    && mkdir -p /etc/rsyslog.d /etc/haproxy /etc/confd /etc/lb /etc/supervisor /var/spool/rsyslog
ENV NODE_PATH /usr/lib/node_modules

# install haproxy
ENV HAPROXY_MAJOR 1.6
ENV HAPROXY_VERSION 1.6.7
ENV HAPROXY_MD5 a046ed63b00347bd367b983529dd541f
RUN set -x \
    && apk add --no-cache --virtual .build-deps \
      curl \
      gcc \
      libc-dev \
      linux-headers \
      make \
      openssl-dev \
      pcre-dev \
      zlib-dev \
    && curl -SL "http://www.haproxy.org/download/${HAPROXY_MAJOR}/src/haproxy-${HAPROXY_VERSION}.tar.gz" -o haproxy.tar.gz \
    && echo "${HAPROXY_MD5}  haproxy.tar.gz" | md5sum -c \
    && mkdir -p /usr/src \
    && tar -xzf haproxy.tar.gz -C /usr/src \
    && mv "/usr/src/haproxy-$HAPROXY_VERSION" /usr/src/haproxy \
    && rm haproxy.tar.gz \
    && make -C /usr/src/haproxy \
      TARGET=linux2628 \
      USE_PCRE=1 PCREDIR= \
      USE_OPENSSL=1 \
      USE_ZLIB=1 \
      all \
      install-bin \
    && cp -R /usr/src/haproxy/examples/errorfiles /etc/haproxy/errors \
    && rm -rf /usr/src/haproxy \
    && runDeps="$( \
      scanelf --needed --nobanner --recursive /usr/local \
        | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
        | sort -u \
        | xargs -r apk info --installed \
        | sort -u \
    )" \
    && apk add --no-cache --virtual .haproxy-rundeps $runDeps \
    && apk del --no-cache .build-deps

# install gotpl & confd
ENV GO_VERSION 1.6.3
RUN set -x \
    && apk add --no-cache go git \
    && export GOPATH=/usr/src/go \
    && go get github.com/tsg/gotpl \
    && mv /usr/src/go/bin/gotpl /usr/bin/gotpl \
    && go get github.com/kelseyhightower/confd \
    && mv /usr/src/go/bin/confd /usr/bin/confd \
    && apk del --no-cache go git

ADD entries.tpl /etc/confd/templates/entries.tpl
ADD entries.toml /etc/confd/conf.d/entries.toml
ADD rsyslog.conf /etc/rsyslog.d/rsyslog.conf
ADD haproxy.cfg.tpl /etc/lb/haproxy.cfg.tpl
ADD supervisor.conf /etc/supervisor/supervisor.conf

VOLUME /etc/haproxy

COPY lb-* /usr/bin/
RUN chmod +x /usr/bin/lb-*

ENTRYPOINT /usr/bin/lb-bootstrap
