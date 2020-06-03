# This file describes the standard way to build a CROPS dispatcher image
#
# Usage:
#
# # Build CODI image with the following command. Replace the "version" tag
# with the current codi version
#
# docker build -t crops/codi:version -f Dockerfile.codi ../
#
# Example: Build CODI version 0.1
#
# docker build -t crops/codi:0.1 -f Dockerfile.codi ../

FROM crops/codi:deps
MAINTAINER Todor Minchev <todor.minchev@linux.intel.com>

# Build and install CODI
RUN mkdir -p /usr/local/crops/codi/
COPY codi /usr/local/crops/codi/
COPY utils.[ch] /usr/local/crops/
COPY globals.[ch] /usr/local/crops/
ARG build_type

RUN	cd /usr/local/crops/codi && \
	make $build_type && \
	mkdir -p /bin/codi && \
	cp /usr/local/crops/codi/codi /bin/codi/run && \
	rm -rf /usr/local/crops

# Monitor CODI and restart it on exit
ENTRYPOINT ["supervise", "/bin/codi"]

# Default CODI port
EXPOSE 10000
