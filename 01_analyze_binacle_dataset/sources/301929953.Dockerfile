FROM debian:stretch-slim

RUN apt-get update && apt-get install -y \
	make \
	wget \
	gcc g++ \
	autoconf automake \
	flex bison \
	git \
	unzip bzip2 \
	libtool libtool-bin \
	gperf \
	texinfo help2man \
	gawk sed \
	ncurses-dev \ 
	libexpat-dev \
	python python-dev python-serial \
	&& rm -rf /var/lib/apt/lists/*

# Create user
RUN useradd -m builder
USER builder

# Install ESP8266 SDK
RUN git clone https://github.com/pfalcon/esp-open-sdk.git /home/builder/esp-open-sdk \
    && cd /home/builder/esp-open-sdk \
    && git reset --hard c70543e57fb18e5be0315aa217bca27d0e26d23d \
    && git submodule update --init --recursive \
    && cd /home/builder/esp-open-sdk; make VENDOR_SDK=2.1.0 STANDALONE=y \
    && rm -rf /home/builder/esp-open-sdk/crosstool-NG/.build

ENV PATH /home/builder/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
ENV XTENSA_TOOLS_ROOT /home/builder/esp-open-sdk/xtensa-lx106-elf/bin
ENV FW_TOOL /home/builder/esp-open-sdk/xtensa-lx106-elf/bin/esptool.py
ENV ESP_HOME /home/builder/esp-open-sdk
ENV SMING_HOME /home/builder/Sming/Sming
ENV SDK_BASE $SMING_HOME/third-party/ESP8266_NONOS_SDK

# Install esptool
RUN git clone --recursive https://github.com/themadinventor/esptool.git /home/builder/esptool \
    && cd /home/builder/esptool \
    && git reset --hard ee00d8421353f43671e84c80cfbd465c33eee77d

ENV PATH /home/builder/esptool:$PATH

# Install esptool2
RUN git clone --recursive https://github.com/raburton/esptool2 /home/builder/esptool2 \
    && cd /home/builder/esptool2 \
    && git reset --hard 3616335ab318cde9e25ba81dbd47097b09603161 \
    && cd /home/builder/esptool2 \
    && make

ENV PATH /home/builder/esptool2:$PATH

# Install sming
RUN git clone https://github.com/esper-hub/Sming.git /home/builder/Sming \
    && cd /home/builder/Sming \
    && git reset --hard 9c7cac2d260798e19e833bbaabf9f30b659425a8 \
    && git submodule update --init --recursive \
    && cd /home/builder/Sming/Sming \
    && make clean \
    && make

ENV COM_PORT /dev/ttyESP
ENV COM_SPEED 115200

# Copy local esper
COPY . /home/builder/esper/

# Switch back user and set workdir for building
USER root
WORKDIR /home/builder/esper

# Set variables for build
ENV ESPER /home/builder/esper
ENV SITE /home/builder/site

CMD make

