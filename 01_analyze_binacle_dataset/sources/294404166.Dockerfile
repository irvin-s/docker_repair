FROM ubuntu:latest
MAINTAINER Rackn Team <eng@rackn.com>
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL=C
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install build-essential gcc-aarch64-linux-gnu git liblzma-dev genisoimage && \
    apt-get -y --no-install-recommends install syslinux isolinux syslinux-common
COPY build_ipxe.sh /bin/build_ipxe.sh
COPY undionly /src/undionly
COPY snponly_x86_64 /src/snponly_x86_64
COPY snponly_arm64 /src/snponly_arm64
COPY lkrn /src/lkrn
#ENTRYPOINT /bin/build_ipxe.sh
