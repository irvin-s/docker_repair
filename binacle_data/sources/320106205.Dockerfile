FROM kafebob/rpi-alpine:3.6
LABEL maintainer="Luis Toubes <luis@toub.es>"

# Inspired from
# https://github.com/sillelien/base-alpine

COPY rootfs /
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-armhf.tar.gz /tmp/s6-overlay.tar.gz

RUN apk update && apk upgrade && \
    apk -U add dnsmasq jq curl vim nano && \
    tar xvfz /tmp/s6-overlay.tar.gz -C /

ENTRYPOINT ["/init"]
CMD []