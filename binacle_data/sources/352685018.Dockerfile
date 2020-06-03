# debian 7.8.0 (wheezy) sparc64 image via qemu.
# Running:
#   docker run -p 2023:2023 danisla/debian-sparc64:latest
# Then:
#   telnet dockerhost 2023
#   user/pass: debian/debian
#   root pass: debian

FROM debian:stretch

MAINTAINER dan.isla@gmail.com

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
  qemu-system \
  qemu-utils \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/app

WORKDIR /opt/app

ENV SPARC_QEMU_DISK debian-7.8.0-sparc64-cleaninstall.img
ENV USE_SNAPSHOT=true

ADD ${SPARC_QEMU_DISK}.gz /opt/app/
RUN gunzip ${SPARC_QEMU_DISK}.gz

ENV SPARC_QEMU_KERNEL vmlinux-3.2.0-4-sparc64
ENV SPARC_QEMU_INITRD initrd.img-3.2.0-4-sparc64

ADD ${SPARC_QEMU_KERNEL} /opt/app/
ADD ${SPARC_QEMU_INITRD} /opt/app/

ADD start.sh /opt/app/
RUN chmod +x /opt/app/start.sh

EXPOSE 2023
EXPOSE 4440

ENTRYPOINT /opt/app/start.sh
