FROM alpine:edge


ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
 && rm -rf /tmp/s6-overlay-amd64.tar.gz

ENV S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES=1


COPY Makefile smf-spf.c /tmp/src/

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" \
      >> /etc/apk/repositories \

 # Upgrade existing packages & install runtime dependencies
 && apk update \
 && apk upgrade \
 && apk add --no-cache \
        libspf2 libmilter@community \

 # Build smf-spf binary
 && apk add --no-cache --virtual .build-deps \
        build-base \
        libspf2-dev libmilter-dev@community \
 && cd /tmp/src \
 && make smf-spf \
 && mv smf-spf /usr/local/bin/ \

 # Clean up unnecessary stuff
 && apk del .build-deps \
 && rm -rf /tmp/src \
           /var/cache/apk/*


COPY docker/rootfs /

COPY smf-spf.conf /etc/smfs/

COPY LICENSE COPYING readme README.md /usr/share/doc/smf-spf/

RUN chmod +x /etc/services.d/*/run \

 # Prepare default configuration
 && sed -i -r 's/^#?Daemonize\s.*$/Daemonize off/g' /etc/smfs/smf-spf.conf \
 && sed -i -r 's/^#?User\s.*$/User nobody/g'        /etc/smfs/smf-spf.conf \
 && sed -i -r 's/^#?Socket\s.*$/Socket inet:8890/g' /etc/smfs/smf-spf.conf \

 # Prepare directory for unix socket
 && mkdir -p /var/run/smfs \
 && chown -R nobody:nobody /var/run/smfs


EXPOSE 8890


ENTRYPOINT ["/init"]

CMD ["smf-spf"]
