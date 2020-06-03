#
# Dockerfile for simple example
#
FROM    debian:latest

# Install node
RUN     export DEBIAN_FRONTEND=noninteractive && \
        apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean && \
        apt-get install -y wget && \
        wget -q http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz && \
        tar --strip-components 1 -xzf node-v* -C /usr/local && \
        apt-get clean; apt-get autoremove && \
        apt-get remove -y wget && \
        rm -rf node-v0.10.33-linux-x64.tar.gz /var/lib/apt/lists/* && \
        node --version && \
        mkdir /bundle; cd /bundle

# Tell Docker to expose the app port
EXPOSE  8080

# The /bundle dir will be mounted at startup
CMD     ["node", "/bundle/app.js"]
