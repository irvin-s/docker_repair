# Base image
FROM alpine:3.9

# Copy root filesystem
COPY rootfs /

# ENV
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV PYTHONUNBUFFERED=0

# Build
RUN \
    apk add --no-cache \
    apache2-utils=2.4.38-r2 \
    apk-tools=2.10.3-r1 \
    bash=4.4.19-r1 \
    ca-certificates=20190108-r0 \
    curl=7.63.0-r0 \
    nginx=1.14.2-r0 \
    redis=4.0.12-r0 \
    python3=3.6.8-r1 \
    \
    && pip3 install --no-cache-dir componentstore==1.2.0 \
    \
    && rm -f -r /tmp/* \
    \
    && curl -L -s https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz \
        | tar xvzf - -C / 

# Entrypoint
ENTRYPOINT [ "/init" ]

# Arguments
ARG BUILD_DATE

# Labels
LABEL \
    maintainer="Joakim Sørensen @ludeeus <ludeeus@gmail.com>" \
    org.label-schema.description="Easy manage custom_components for Home Assistant." \
    org.label-schema.name="custom-component-store" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://github.com/ludeeus/custom-component-store" \
    org.label-schema.usage="https://github.com/ludeeus/custom-component-store/blob/master/README.md"