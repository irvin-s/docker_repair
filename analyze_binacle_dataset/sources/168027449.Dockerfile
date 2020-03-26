FROM ubuntu:14.04

MAINTAINER Benjamin Henrion <zoobab@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q git autoconf build-essential gperf bison flex texinfo libtool libncurses5-dev wget apt-utils gawk sudo unzip libexpat-dev

RUN useradd -d /home/esp8266 -m -s /bin/bash esp8266
RUN echo "esp8266 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/esp8266
RUN chmod 0440 /etc/sudoers.d/esp8266

USER esp8266

WORKDIR /home/esp8266
RUN git clone -b lx106 https://github.com/jcmvbkbc/crosstool-NG.git
WORKDIR /home/esp8266/crosstool-NG
RUN ./bootstrap
RUN ./configure --prefix=`pwd`
RUN make -j`nproc`
RUN sudo make install
RUN ./ct-ng xtensa-lx106-elf
RUN ./ct-ng build
RUN mkdir ~/sdk

WORKDIR /home/esp8266/sdk
RUN wget -q http://filez.zoobab.com/esp8266/esptool-0.0.2.zip
RUN unzip esptool-0.0.2.zip
WORKDIR /home/esp8266/sdk/esptool
RUN sed -i 's/WINDOWS/LINUX/g' Makefile
RUN make
