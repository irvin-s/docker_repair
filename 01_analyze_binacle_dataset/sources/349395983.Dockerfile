FROM ubuntu:12.04

RUN apt-get -y update ; apt-get -y upgrade
RUN apt-get -y install apt-utils make ia32-libs u-boot-tools lzma zlib1g-dev bison flex yodl
RUN apt-get -y install git --fix-missing

COPY arm-2011.03-wirgrid /opt
ENV PATH=$PATH:/opt/bin
ENV CROSS_COMPILE=arm-none-linux-gnueabi-
