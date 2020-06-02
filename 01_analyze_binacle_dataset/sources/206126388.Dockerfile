# This file describes the standard way to build the dependencies for Zephyr
# toolchain images
#
# Usage:
#
# docker build -t crops/zephyr:deps -f Dockerfile.zephyr.deps .

FROM debian:wheezy
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
	python	\
	daemontools \
	git \
	make \
	gcc \
	gcc-multilib \
	g++ \
	libc6-dev-i386 \
	g++-multilib	\
	bzip2	\
	wget

