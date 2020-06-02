FROM socrata/runit
MAINTAINER Socrata <sysadmin@socrata.com>

# Add the NodeSource apt repository. Instructions taken from:
# https://github.com/nodesource/distributions/blob/master/README.md#debmanual
ENV NODE_VERSION=node_10.x
RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
RUN echo "deb https://deb.nodesource.com/$NODE_VERSION $(lsb_release -s -c) main" | \
    tee /etc/apt/sources.list.d/nodesource.list
RUN echo "deb-src https://deb.nodesource.com/$NODE_VERSION $(lsb_release -s -c) main" | \
    tee -a /etc/apt/sources.list.d/nodesource.list

RUN apt-get -y update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libyajl2 nodejs

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/nodejs_10x=""
