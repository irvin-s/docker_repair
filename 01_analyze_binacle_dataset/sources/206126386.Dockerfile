# This file describes the standard way to build the dependencies for CROPS
# toolchain images
#
# Usage:
#
# docker build -t crops/toolchain:deps -f Dockerfile.toolchain.deps .

FROM debian:wheezy
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Install dependencies
RUN apt-get update -qq && apt-get install -y -qq \
	python	\
	daemontools \
	git \
	build-essential \
	wget

