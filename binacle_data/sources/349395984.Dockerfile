FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install curl bzip2 python

# Installing Multitech toolchain
RUN curl http://www.multitech.net/mlinux/sdk/3.2.0/mlinux-eglibc-x86_64-mlinux-factory-image-arm926ejste-toolchain-3.2.0.sh > mlinux-toolchain-install.sh
RUN chmod +x mlinux-toolchain-install.sh
RUN ./mlinux-toolchain-install.sh

ENV CFG_SPI=ftdi
ENV PLATFORM=multitech
