FROM ubuntu:16.04
MAINTAINER Madhuri Yechuri <cosmokramer@gmail.com>

# Get OSv base ELF
RUN mkdir -p /osv/base
COPY ./loader-x86_64.elf /osv/base/loader.elf

# Get binutils for access to readelf
RUN apt-get update && \
    apt-get install -y build-essential vim upx curl qemu-utils qemu-kvm
RUN upx -d /osv/base/loader.elf

# Install Capstan
RUN curl https://raw.githubusercontent.com/cloudius-systems/capstan/master/scripts/download | bash

# Validate application for OSv
COPY ./build-app-osv.sh /osv/build-app-osv.sh
RUN chmod +x /osv/build-app-osv.sh
COPY ./check-app-osv-fit.sh /osv/checks/check-app-osv-fit.sh
RUN chmod +x /osv/checks/check-app-osv-fit.sh
COPY ./create-osv-image.sh /osv/create-osv-image.sh
RUN chmod +x /osv/create-osv-image.sh

# CMD /bin/bash
ENTRYPOINT ["/osv/build-app-osv.sh"]


