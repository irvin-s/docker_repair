FROM alpine:3.7

# add user and group first so their IDs don't change
RUN addgroup oauth2_proxy && adduser -G oauth2_proxy  -D -H oauth2_proxy

# su/sudo with proper signaling inside docker
RUN apk add --no-cache su-exec

ENV OAUTH2_PROXY_VERSION="2.2"

# install zeppelin
RUN set -xe \
    && apk add --no-cache --virtual .run-deps \
        bash \
        ca-certificates \
        curl \
    && apk add --no-cache --virtual .build-deps \
        tar \
    \
    && curl -O -fSL "https://github.com/bitly/oauth2_proxy/releases/download/v${OAUTH2_PROXY_VERSION}/oauth2_proxy-${OAUTH2_PROXY_VERSION}.0.linux-amd64.go1.8.1.tar.gz" \
    && mkdir /oauth2_proxy \
    && tar -xf oauth2_proxy-${OAUTH2_PROXY_VERSION}.0.linux-amd64.go1.8.1.tar.gz -C /oauth2_proxy --strip-components=1 --no-same-owner \
    && rm oauth2_proxy-${OAUTH2_PROXY_VERSION}.0.linux-amd64.go1.8.1.tar.gz \
    \
    && curl -O -fSL "https://raw.githubusercontent.com/bitly/oauth2_proxy/v${OAUTH2_PROXY_VERSION}/contrib/oauth2_proxy.cfg.example" \
    && mkdir /conf \
    && mv oauth2_proxy.cfg.example /conf/oauth2_proxy.cfg.dist \
    \
    && mkdir /templates \
    \
    && chown -R oauth2_proxy:oauth2_proxy /conf /templates /oauth2_proxy \
    \
    && apk del .build-deps

ENV PATH /oauth2_proxy:$PATH

VOLUME [ "/templates" ]

EXPOSE 4180

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
    CMD curl --silent --fail http://localhost:4180/ping || exit 1

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["oauth2_proxy", "--config", "/conf/oauth2_proxy.cfg"]

