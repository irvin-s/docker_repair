FROM nutshells/base
LABEL maintainer='Chao QU <mail@quchao.com>'

WORKDIR /usr/local/src/

ARG DNSMASQ_COMMIT='3390db4'
ARG DNSMASQ_SHA256='9b1a08c5c6fa55784a21db7019bba16d07c8a6d57ec8029d1b52becb9e5626e1'
ARG DNSMASQ_VERSION='v2.77test4'
ARG WITH_DNSSEC='true'
ARG WITH_IDN='true'

ENV SAMPLE_CFG_DIR='/usr/local/share/dnsmasq' \
    CFG_DIR='/usr/local/etc/dnsmasq' \
    LISTEN_PORT='12345'

RUN set -ex; \
    # build deps
    apk add --no-cache --virtual .build-deps \
        build-base \
        linux-headers \
        libidn-dev \
        nettle-dev \
    ; \
    # runtime deps
    apk add --no-cache --virtual .runtime-deps \
        nettle \
    ; \
    # extra tools
    apk add --no-cache --virtual .extra-tools \
        bind-tools \
    ; \
    curl -sSLO "https://github.com/infinet/dnsmasq/archive/${DNSMASQ_COMMIT}.tar.gz"; \
    echo "${DNSMASQ_SHA256}  ${DNSMASQ_COMMIT}.tar.gz" | sha256sum -c -; \
    tar xzf "${DNSMASQ_COMMIT}.tar.gz"; \
    mv dnsmasq-* dnsmasq; \
    cd dnsmasq; \
    # fix version number
    echo "${DNSMASQ_VERSION}" > VERSION; \
    # build with DNSSEC enabled, pt.1
    if [ "${WITH_DNSSEC}" = 'true' ]; then \
        sed -i 's|^/\* #define HAVE_DNSSEC \*/|#define HAVE_DNSSEC|' src/config.h; \
    fi; \
    # build with IDN support
    if [ "${WITH_IDN}" = 'true' ]; then \
        sed -i 's|^/\* #define HAVE_IDN \*/|#define HAVE_IDN|' src/config.h; \
        # runtime deps complement
        apk add --no-cache --virtual .runtime-deps \
            libidn \
        ; \
    fi; \
    make; \
    # install w/o manpage
    #make install; \
    mkdir /usr/local/sbin/; \
    cp src/dnsmasq /usr/local/sbin/; \
    # config loader
    mkdir -p "${CFG_DIR}"; \
    echo "conf-dir=${CFG_DIR},*.conf" >> /etc/dnsmasq.conf; \
    # tailer the sample confs
    mkdir -p "${SAMPLE_CFG_DIR}"; \
    # build with DNSSEC enabled, pt.2
    if [ "${WITH_DNSSEC}" = 'true' ]; then \
        sed -i 's|^#dnssec|dnssec|g' dnsmasq.conf.example; \
        echo "#Copy the DNSSEC Authenticated Data bit from upstream servers to downstream clients and cache it. This is an alternative to having dnsmasq validate DNSSEC, but it depends on the security of the network between dnsmasq and the upstream servers, and the trustworthiness of the upstream servers." >> dnsmasq.conf.example; \
        echo "#proxy-dnssec" >> dnsmasq.conf.example; \
        cat trust-anchors.conf >> dnsmasq.conf.example; \
    fi; \
    sed -i '/^# Include /d' dnsmasq.conf.example; \
    sed -i '/^#conf-/d' dnsmasq.conf.example; \
    cp dnsmasq.conf.example "${SAMPLE_CFG_DIR}"; \
    cd ..; \
    rm -f "${DNSMASQ_COMMIT}.tar.gz"; \
    rm -rf dnsmasq; \
    # do some cleanup
    apk del --purge .build-deps; \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /usr/local/src/*;

COPY docker-entrypoint.sh /usr/local/bin/

RUN set -ex; \
    chmod +x /usr/local/bin/docker-entrypoint.sh;

HEALTHCHECK --interval=1m --timeout=3s \
    CMD [[ -n "$(dig @127.0.0.1 +time=3 +short -p "${LISTEN_PORT}" google.com)" ]] || exit 1

EXPOSE ${LISTEN_PORT}/udp

#VOLUME [ "${CFG_DIR}" ]
WORKDIR /usr/local/var/dnsmasq
ENTRYPOINT [ "docker-entrypoint.sh" ]
