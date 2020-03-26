FROM alpine:edge
LABEL maintainer='Chao QU <mail@quchao.com>'

RUN set -ex; \
    # enable edge repos
    echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories; \
    echo '@community http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories; \
    # change mirrors
    sed -i 's|http://dl-cdn.alpinelinux.org|https://mirrors.aliyun.com|g' /etc/apk/repositories; \
    # keep update-to-date
    apk update; \
    apk upgrade; \
    # runtime deps
    apk add --no-cache --virtual .common-deps \
        ca-certificates@edge \
        su-exec@edge \
        curl@edge \
    ; \
    # reset CA list
    update-ca-certificates --fresh; \
    # cleaning
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*;

ARG RUN_AS_USER
ENV RUN_AS_USER="${RUN_AS_USER:-nutshell}"

RUN set -ex; \
    # a low-privilege user
    addgroup -S "${RUN_AS_USER}"; \
    adduser -S -D -H  -h /var/empty -s /sbin/nologin -G "${RUN_AS_USER}" "${RUN_AS_USER}";

COPY docker-entrypoint.sh entrypoint-utils.sh /usr/local/bin/

RUN set -ex; \
    # test flight
	chmod +x /usr/local/bin/docker-entrypoint.sh;

RUN set -ex; \
    # avoid docker's 'Text file busy' issue
	docker-entrypoint.sh /bin/true;
