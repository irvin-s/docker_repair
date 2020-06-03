# This file is a combination of all the other things for building one massive container ...
FROM ubuntu:16.04

COPY rootfs /

ENV INITRD no
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
ENV ALLOW_DEBUG true
ENV NODE_VERSION 5.0.0
ENV NPM_VERSION 3.3.11
ENV PATH "$PATH:/usr/local/n/bin"

COPY build.sh /build.sh
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.15.0.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz

EXPOSE 80
EXPOSE 443

RUN /build.sh base
RUN /build.sh nginx
RUN /build.sh php
RUN /build.sh node
