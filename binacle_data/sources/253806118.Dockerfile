FROM ubuntu:16.04
MAINTAINER Madhuri Yechuri <cosmokramer@gmail.com>

# Get OSv base ELF
RUN mkdir -p /osv/base
COPY ./loader-aarch64.elf /osv/base/loader.elf

# Get binutils for access to readelf
RUN apt-get update && \
    apt-get install -y build-essential vim upx curl qemu-utils qemu-kvm && \
    apt-get install -y g++-aarch64-linux-gnu gcc-aarch64-linux-gnu python qemu-system-arm

# Get osv git tree at https://github.com/myechuri/osv/commit/60a968b7ae88937e64e27a0bd50479307cc90c87
RUN apt-get install -y wget && \
    wget --directory-prefix=/ https://s3-us-west-2.amazonaws.com/osv-images/aarch64osv.tar.gz && \
    tar -xvf /aarch64osv.tar.gz --directory /

# Validate application for OSv
COPY ./build-app-osv.sh /osv/build-app-osv.sh
RUN chmod +x /osv/build-app-osv.sh
COPY ./check-app-osv-fit.sh /osv/checks/check-app-osv-fit.sh
RUN chmod +x /osv/checks/check-app-osv-fit.sh
COPY ./create-osv-image.sh /osv/create-osv-image.sh
RUN chmod +x /osv/create-osv-image.sh

# CMD /bin/bash
ENTRYPOINT ["/osv/build-app-osv.sh"]


