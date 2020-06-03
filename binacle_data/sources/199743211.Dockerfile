FROM debian:stable-slim

ENV DOCKER=1 DEBIAN_FRONTEND=noninteractive

# Add support for apt-* packages caching through "apt-cacher-ng"
ARG APTPROXY
RUN bash -c 'if [ -n "$APTPROXY" ]; then echo "Acquire::HTTP::Proxy \"http://$APTPROXY\";" > /etc/apt/apt.conf.d/01proxy; fi'

## Install dependencies
RUN apt-get update \
    && apt-get --no-install-recommends install -y vim-tiny \

    # Install latest NodeJS + NPM
    && apt-get --no-install-recommends install -y curl ca-certificates apt-transport-https lsb-release \
    && curl -sSL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get --no-install-recommends install -y nodejs \

    # Install global NPM packages
    && npm install -g webpack \

    # Cleanup after installation
    && npm cache clear \
    && rm -rf /tmp/npm-* \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -fr /var/lib/apt/lists/* \

    # Create basic project structure
    && mkdir -p /app/project/assets/

ADD project/assets/package.json /app/package.json

RUN cd /app \
    && npm install \
    && npm cache clear

WORKDIR /app/project/assets/

EXPOSE 8000