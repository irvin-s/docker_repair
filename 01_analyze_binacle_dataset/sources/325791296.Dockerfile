ARG BUILD_FROM=hassioaddons/base:2.3.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Copy root filesystem
COPY rootfs /

# Setup base
RUN \
    apk add --no-cache python3=3.6.6-r0 \
    \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install "requests>=2.14.2" "pyyaml>=3.11,<4" \
    \
    && curl -L -s -o ~/lovelace_migrate.py \
        "https://raw.githubusercontent.com/dale3h/python-lovelace/20b5d7b8a0fb189c5357f2c0de3513a08346ca39/lovelace_migrate.py"

# Script to run after startup
CMD ["/usr/bin/run.sh"]

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Lovelace Migration" \
    io.hass.description="Automatically convert your existing UI to the new Lovelace UI" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Dale Higgs <dale3h@addons.community>" \
    org.label-schema.description="Automatically convert your existing UI to the new Lovelace UI" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Lovelace Migration" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/t/community-hass-io-add-on-lovelace-migration/61552?u=dale3h" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-lovelace-migration/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-lovelace-migration" \
    org.label-schema.vendor="Community Hass.io Addons"
