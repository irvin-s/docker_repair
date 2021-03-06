FROM ubuntu:18.10
MAINTAINER Marco Poletti <poletti.marco@gmail.com>

COPY ubuntu-18.10_custom.list /etc/apt/sources.list.d/
COPY common_install.sh common_cleanup.sh ubuntu-18.10_install.sh /

RUN bash -x /common_install.sh && \
    bash -x /ubuntu-18.10_install.sh && \
    bash -x /common_cleanup.sh
