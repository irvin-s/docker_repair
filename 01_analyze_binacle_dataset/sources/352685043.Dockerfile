# netbsd 6.1.5 sparc64 image via qemu.
# Running:
#   docker run -p 2023:2023 danisla/netbsd-sparc64:latest
# Then:
#   telnet dockerhost 2023
#   user/pass: netbsd/netbsd2015
#   root pass: netbsd2015

FROM debian:stretch

MAINTAINER dan.isla@gmail.com

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  qemu-system \
  qemu-utils \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/app

WORKDIR /opt/app

ENV SPARC_QEMU_DISK netbsd6-sparc-std-cleaninstall.img
ENV USE_SNAPSHOT=true

ADD ${SPARC_QEMU_DISK}.gz /opt/app/
RUN gunzip ${SPARC_QEMU_DISK}.gz

ADD start.sh /opt/app/
RUN chmod +x /opt/app/start.sh

EXPOSE 2023
EXPOSE 4440

ENTRYPOINT /opt/app/start.sh
