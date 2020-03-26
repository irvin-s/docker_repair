# Dockerfile
FROM python:3.6.7-alpine
LABEL maintainer="Ender Su <ender@biilabs.io>"

# Install python3 dependencies
RUN apk add --virtual build-tools libffi-dev openssl-dev build-base \
    && pip3 install pyota \
    && apk del build-tools

# Copy source code into docker image
ADD . /iota-swarm-node

EXPOSE      8000
WORKDIR     /iota-swarm-node
CMD         [ "python3", "/iota-swarm-node/server.py" ]