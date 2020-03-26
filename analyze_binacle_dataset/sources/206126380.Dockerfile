# This file describes the standard way to cross compile ceed with mingw
#
# Example:
#
# docker build -t crops/ceed:0.1 -f Dockerfile.ceed.win ../

FROM crops/ceed:deps
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>
LABEL name="ceed-windows"

# Build and install CEED
RUN mkdir -p /usr/local/crops/ceed/
COPY ceed /usr/local/crops/ceed/
COPY utils.[ch] /usr/local/crops/
COPY globals.[ch] /usr/local/crops/

RUN cd /usr/local/crops/ceed && \
  CC=x86_64-w64-mingw32-gcc make

