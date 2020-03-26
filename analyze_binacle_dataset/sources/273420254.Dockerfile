FROM alpine:edge

COPY conf /etc/caddy/

RUN apk --update upgrade \
    && apk add --no-cache --no-progress tini ca-certificates curl \
    && apk add --no-cache --no-progress --virtual .build_tools wget tar bash \
    && wget -qO- https://getcaddy.com \
      | bash -s http.ipfilter \
    && apk del --purge .build_tools \
    && mkdir /.caddy \
    && rm -rf \
      /usr/share/doc \
      /usr/share/man \
      /tmp/* \
      /var/cache/apk/*

EXPOSE 7575

HEALTHCHECK --interval=1m --timeout=15s \
    CMD curl -f http://127.0.0.1:7575/version || exit 1

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["caddy", "-agree", "--conf", "/etc/caddy/Caddyfile"]
