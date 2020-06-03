FROM nutshells/base
LABEL maintainer='Chao QU <mail@quchao.com>'

ARG DNSCRYPT_SHA256='6bd025d17411c2e220c3a70f8bcb3188f08a79b40020e51b1749b791269c7d77'
ARG DNSCRYPT_VERSION='0.3'

WORKDIR /usr/local/src/

RUN set -ex; \
    # build deps
    apk add --no-cache --virtual .build-deps \
        #shadow \
        build-base \
        linux-headers \
        autoconf \
        bsd-compat-headers \
        libsodium-dev \
        libevent-dev \
    ; \
    # runtime deps
    apk add --no-cache --virtual .runtime-deps \
        libsodium \
        libevent \
    ; \
    curl -sSLO "https://github.com/cofyc/dnscrypt-wrapper/archive/v${DNSCRYPT_VERSION}.tar.gz"; \
    echo "${DNSCRYPT_SHA256}  v${DNSCRYPT_VERSION}.tar.gz" | sha256sum -c -; \
    tar xfz "v${DNSCRYPT_VERSION}.tar.gz"; \
    cd "dnscrypt-wrapper-${DNSCRYPT_VERSION}"; \
    # disable backtrace
    sed -i 's|HAVE_BACKTRACE|NO_BACKTRACE|' compat.h; \
    make configure; \
    env CFLAGS=-Ofast ./configure; \
    make install; \
    cd ..; \
    rm -f "v${DNSCRYPT_VERSION}.tar.gz"; \
    rm -rf "dnscrypt-wrapper-${DNSCRYPT_VERSION}"; \
    # for chroot
    #usermod -d '/usr/local/var/dnscrypt-wrapper' "${RUN_AS_USER}"; \
    #chown "${RUN_AS_USER}":"${RUN_AS_USER}" /usr/local/var/dnscrypt-wrapper; \
    # do some cleanup
    apk del --purge .build-deps; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /usr/local/src/*;

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -ex; \
    chmod +x /usr/local/bin/docker-entrypoint.sh; \
    chown "${RUN_AS_USER}":"${RUN_AS_USER}" /usr/local/sbin/dnscrypt-wrapper;

ENV LISTEN_PORT='12345' \
    RESOLVER_IP='8.8.8.8' \
    RESOLVER_PORT='53' \
    PROVIDER_BASENAME='example.com' \
    CRYPT_KEYS_LIFESPAN='365' \
    KEYS_DIR='/usr/local/etc/dnscrypt-wrapper'
ENV CRYPT_KEYS_DIR="${KEYS_DIR}/crypt"

HEALTHCHECK --interval=1m --timeout=3s \
    CMD [[ "$(/usr/bin/find "${CRYPT_KEYS_DIR}" -maxdepth 1 -type f -name '*.key' -mmin -"$((CRYPT_KEYS_LIFESPAN * 1440 * 7 / 10))" -print | wc -l | sed 's|[^0-9]||g')" -ne 0 ]] || exit 1
STOPSIGNAL SIGKILL

EXPOSE ${LISTEN_PORT}/tcp ${LISTEN_PORT}/udp

VOLUME [ "${KEYS_DIR}" ]
WORKDIR ${KEYS_DIR}
ENTRYPOINT [ "docker-entrypoint.sh" ]
