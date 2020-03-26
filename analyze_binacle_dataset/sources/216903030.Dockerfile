FROM alpine:3.4

ENV HAPROXY_MAJOR 1.6
ENV HAPROXY_VERSION 1.6.9
ENV HAPROXY_MD5 c52eee40eb66f290d6f089c339b9d2b3

# see http://sources.debian.net/src/haproxy/1.5.8-1/debian/rules/ for some helpful navigation of the possible "make" arguments
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
  && mkdir -p /usr/local/etc/haproxy \
  && cp -R /usr/src/haproxy/examples/errorfiles /usr/local/etc/haproxy/errors \
  && rm -rf /usr/src/haproxy \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .haproxy-rundeps $runDeps \
  && apk del .build-deps

# Customisation from haproxy upstream
RUN apk add --no-cache inotify-tools curl python py-pip && \
    pip install requests

ENV STACK_DOMAIN none
ENV ENABLE_STATS false
ENV STATS_PORT 1936
ENV STATS_USERNAME haproxy
ENV STATS_PASSWORD haproxy
ENV ENABLE_SSL false
ENV ENABLE_SSL_REDIRECTION false
ENV SSL_REDIRECTION_TYPE 301
ENV SSL_BASE64_ENCODED false
ENV DISABLE_METADATA false
ENV HAPROXY_CONFIG /usr/local/etc/haproxy/haproxy.cfg
ENV HAPROXY_SSL_CERT /usr/local/etc/haproxy/server.pem
ENV HAPROXY_BACKEND_CONFIG /usr/local/etc/haproxy/haproxy-backends.cfg
ENV HAPROXY_DOMAIN_MAP /usr/local/etc/haproxy/domain.map
ENV RANCHER_API_HOST rancher-metadata.rancher.internal
ENV RANCHER_API_VERSION 2015-12-19
ENV RANCHER_LABEL map-public-http
ENV RANCHER_PROXY_LABEL send-proxy

COPY gen-haproxy-map.py /
COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["haproxy"]

