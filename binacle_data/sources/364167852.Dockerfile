# Container running Event Store
#
# VERSION               0.1
FROM ubuntu:trusty

# That's me :)
MAINTAINER Thomas Ploch "thomas.ploch@tp-solutions.de"

# Set up required env vars
ENV DEBIAN_FRONTEND=noninteractive \
  EVENTSTORE_INT_HTTP_PREFIXES=http://127.0.0.1:2112/ \
  EVENTSTORE_EXT_HTTP_PREFIXES=http://*:2113/ \
  EVENTSTORE_INT_IP=127.0.0.1 \
  EVENTSTORE_EXT_IP=0.0.0.0 \
  EVENTSTORE_ADD_INTERFACE_PREFIXES=0

# Install wget and https transport for apt
RUN apt-get update && apt-get install -y \
  apt-transport-https \
  wget

# Install the eventstore key and the apt repository
RUN wget -O - https://apt-oss.geteventstore.com/eventstore.key | apt-key add - && \
  echo "deb [arch=amd64] https://apt-oss.geteventstore.com/ubuntu/ trusty main" > /etc/apt/sources.list.d/eventstore.list && \
  apt-get update

# Install specific version of eventstore. Change to build a different versioned image
RUN apt-get install -y eventstore-oss=3.3.0

# Expose the public/internal ports
EXPOSE 2113 1113 2112 1112

# Create the volumes
VOLUME /var/lib/eventstore /var/log/eventstore

# Run as eventstore user
USER eventstore

# set entry point to eventstore executable
ENTRYPOINT ["eventstored", "--log=/var/log/eventstore", "--db=/var/lib/eventstore"]
