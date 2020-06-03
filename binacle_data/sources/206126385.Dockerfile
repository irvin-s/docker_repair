# This file describes the standard way to build a CROPS toolchain image
#
# Usage:
#
# 1) Replace the TOOLCHAIN_NAME and TOOLCHAIN_PATH environment variables below with
# the name and URL of your self-extracting toolchain
#
# Example:
#
# ENV TOOLCHAIN_NAME poky-glibc-x86_64-core-image-sato-i586-toolchain-2.0.sh
# ENV TOOLCHAIN_PATH http://downloads.yoctoproject.org/releases/yocto/yocto-2.0/toolchain/x86_64/
#
# 2) Build your toolchain image with the following command replacing my_tag with your target arch
# docker build -t crops/toolchain:my_tag -f Dockerfile.toolchain ../
#
# Example for i586 target:
# docker build -t crops/toolchain:i586 -f Dockerfile.toolchain ../
#
# The default configuration below will build an i586 toolchain for an x86_64 host

FROM crops/toolchain:deps
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

ENV TOOLCHAIN_NAME poky-glibc-x86_64-core-image-sato-i586-toolchain-2.0.sh
ENV TOOLCHAIN_PATH http://downloads.yoctoproject.org/releases/yocto/yocto-2.0/toolchain/x86_64/

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

# Download and install toolchain
RUN wget -q -P /tmp ${TOOLCHAIN_PATH}${TOOLCHAIN_NAME} && \
	cd /tmp &&	\
	chmod 755 ./${TOOLCHAIN_NAME} &&	\
	./${TOOLCHAIN_NAME} -d /opt/poky/ -y

# Make environment setup script executable and setup workspaces
RUN chmod 755 /opt/poky/environment-setup*

# Container entry point
ENTRYPOINT ["/bin/turff_launcher", "-f", "/opt/poky/environment-setup*"]
