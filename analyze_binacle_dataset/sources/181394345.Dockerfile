FROM quay.io/justcontainers/base-without-s6:v14.04.5
MAINTAINER Gorka Lerchundi Osa <glertxundi@gmail.com>

##
## ROOTFS
##

# root filesystem
COPY rootfs /

# s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /

##
## INIT
##

ENTRYPOINT [ "/init" ]
