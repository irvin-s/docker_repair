#!/bin/bash

FROM ubuntu:14.04.3
RUN apt-get update
RUN apt-get install wget -y

RUN echo "ALL ALL=NOPASSWD: ALL" > /etc/sudoers.d/open-sudo
RUN chmod 0440 /etc/sudoers.d/open-sudo

ADD ./build-qemu.sh /root/build-qemu.sh
RUN chmod +x /root/build-qemu.sh
RUN /root/build-qemu.sh
