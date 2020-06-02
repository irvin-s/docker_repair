FROM ubuntu:14.04

# Install deps
RUN apt-get -q update \
		&& apt-get install -y git lib32stdc++6 python python-pip build-essential lib32z1 wget ca-certificates gcc-multilib g++-multilib curl --no-install-recommends \
		&& apt-get clean \
		&& rm -rf /var/lib/apt/lists/*

# Install AWS CLI
RUN pip install awscli

# Set ENV vars
ENV AR /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-ar
ENV CC /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-gcc
ENV CXX /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-g++
ENV LINK /tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/bin/arm-linux-gnueabihf-g++


RUN git clone https://github.com/raspberrypi/tools.git --depth 1 \
		&& git clone https://github.com/nodejs/node.git

COPY . /
