# This file describes the standard way to build a Zephyr toolchain image
#
# Usage:
#
# 1) Replace the TOOLCHAIN_NAME and TOOLCHAIN_PATH environment variables below with
# the name and URL of your self-extracting toolchain
#
# Example:
#
# ENV TOOLCHAIN_NAME zephyr-sdk-0.7.5-i686-setup.run
# ENV TOOLCHAIN_PATH https://nexus.zephyrproject.org/content/repositories/releases/org/zephyrproject/zephyr-sdk/0.7.5-i686/
#
# 2) Build your toolchain image with the following command replacing my_tag with your Zephyr's release
# docker build -t crops/zephyr:my_tag -f Dockerfile.zephyr ../
#
# Example for Zephyr SDK 0.7.5:
# docker build -t crops/zephyr:0.7.5-src -f Dockerfile.zephyr ../
#

FROM crops/zephyr:deps
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

ENV TOOLCHAIN_NAME zephyr-sdk-0.7.5-i686-setup.run
ENV TOOLCHAIN_PATH https://nexus.zephyrproject.org/content/repositories/releases/org/zephyrproject/zephyr-sdk/0.7.5-i686/

# Build and install turff
RUN mkdir -p /usr/local/crops/turff/
COPY turff /usr/local/crops/turff/
COPY utils.[ch] /usr/local/crops/
COPY globals.[ch] /usr/local/crops/

RUN cd /usr/local/crops/turff && \
	make && \
	mkdir -p /bin/turff && \
	cp /usr/local/crops/turff/turff /bin/turff/run && \
	cp /usr/local/crops/turff/turff_launcher /bin/

# Download and install Zephyr toolchain
RUN wget -q -P /tmp ${TOOLCHAIN_PATH}${TOOLCHAIN_NAME} && \
	cd /tmp &&	\
	chmod 755 ./${TOOLCHAIN_NAME} && \
	./${TOOLCHAIN_NAME} && \
	rm -rf ./${TOOLCHAIN_NAME}

#Linkups
# /bin/sh to bash
# easy to use gdb to various architectures
# NOTE: in future we will probably split these into separate toolchain containers
RUN rm /bin/sh && ln -s /bin/bash /bin/sh && \
    ln -s /opt/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/i586-poky-elf/i586-poky-elf-gdb /usr/bin/zephyr-i586-gdb && \
    ln -s /opt/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/arm-poky-eabi/arm-poky-eabi-gdb /usr/bin/zephyr-arm-gdb && \
    ln -s /opt/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/arc-poky-elf/arc-poky-elf-gdb /usr/bin/zephyr-arc-gdb && \
    ln -s /opt/zephyr-sdk/sysroots/i686-pokysdk-linux/usr/bin/mips-poky-elf/mips-poky-elf-gdb /usr/bin/zephyr-mips-gdb

#Create Zephyr bare clone
RUN git clone --bare https://gerrit.zephyrproject.org/r/zephyr /zephyr-src

# Container entry point
ENTRYPOINT ["/bin/turff_launcher"]
