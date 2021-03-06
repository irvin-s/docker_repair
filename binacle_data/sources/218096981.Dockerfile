# Copyright (c) 2016-2019 Crave.io Inc. All rights reserved
FROM accupara/ubuntu:16.04
MAINTAINER Crave.io Inc. "contact@crave.io"

# Keep the update separate so that Docker build system can cache it.
RUN sudo apt-get update
RUN sudo apt-get install --no-install-recommends -y  \
    build-essential     \
    gcc-multilib        \
    libpcap-dev         \
    linux-headers-generic \
    && sudo rm -rf /var/lib/apt/lists/*

ENV RTE_KERNELDIR /usr/src/linux-headers-4.4.0-64-generic

# Compile using "make config T=x86_64-native-linuxapp-gcc && make"
