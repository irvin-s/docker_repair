FROM debian:jessie
MAINTAINER Respoke <info@respoke.io>

RUN useradd --system asterisk

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends \
            autoconf \
            binutils-dev \
            build-essential \
            ca-certificates \
            curl \
            libcurl4-openssl-dev \
            libedit-dev \
            libgsm1-dev \
            libjansson-dev \
            libogg-dev \
            libpopt-dev \
            libresample1-dev \
            libspandsp-dev \
            libspeex-dev \
            libspeexdsp-dev \
            libsqlite3-dev \
            libsrtp0-dev \
            libssl-dev \
            libvorbis-dev \
            libxml2-dev \
            libxslt1-dev \
            portaudio19-dev \
            python-pip \
            unixodbc-dev \
            uuid \
            uuid-dev \
            xmlstarlet \
            && \
    pip install j2cli && \
    apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*

ENV ASTERISK_VERSION=14.0.2
COPY build-asterisk.sh /build-asterisk
RUN /build-asterisk && rm -f /build-asterisk
COPY asterisk-docker-entrypoint.sh /
CMD ["/usr/sbin/asterisk", "-f"]
ENTRYPOINT ["/asterisk-docker-entrypoint.sh"]
