# This file describes the standard way to build the dependencies required for
# cross compiling ceed with mingw
#
# Usage:
#
# docker build -t crops/ceed:deps -f Dockerfile.ceed.deps .

FROM debian:jessie
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Install dependencies
RUN apt-get update && apt-get install -y \
  mingw-w64 \
  gcc \
  make

