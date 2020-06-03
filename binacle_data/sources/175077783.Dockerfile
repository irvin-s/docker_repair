FROM quay.io/signalfuse/maestro-base:alp-3.2

MAINTAINER Ozan Turgut <ozan@signalfuse.com>

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt/s3-server/

# Install node
RUN apk-install nodejs

# Install s3-server
ADD . /opt/s3-server/
RUN npm install --production

# Run the server
CMD node bin/server.js
