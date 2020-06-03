# A base Docker image that all Chainpoint Node.js based
# images will inherit from.

# Node.js LTS on Alpine Linux
# see: https://github.com/nodejs/LTS
# see: https://hub.docker.com/_/node/
# see: https://alpinelinux.org/
FROM node:8.9.0-alpine

LABEL MAINTAINER="Glenn Rempe <glenn@tierion.com>"

# Upgrade packages to latest
RUN apk update && \
    apk upgrade && \
    rm -rf /var/cache/apk/*

# tini
#   A tiny but valid `init` for containers
#   see: https://github.com/krallin/tini
#
# su-exec
#   A tool to switch user and group id and exec
#   see: https://github.com/ncopa/su-exec
#
RUN apk add --update tini su-exec --no-cache

# Common Dependencies
RUN apk add bash nano vim htop curl wget jq --no-cache

# Needed to load native node modules
# See : https://github.com/grpc/grpc/issues/8528
RUN apk add libc6-compat --no-cache

# Needed for ETH libs
RUN apk add git make gcc g++ python --no-cache

# The `node` user and its home dir is provided by
# the base image. Create a subdir where the app code
# will live.
RUN mkdir /home/node/app

# Commands that follow, in this or inheriting containers,
# will be run in the context of this directory.
WORKDIR /home/node/app

# Set required environment variables
ENV NODE_ENV production

# All CMD's in containers that inherit from this base
# will be prefixed with the following command wrapper
# defined in this ENTRYPOINT. They'll be wrapped to:
#
#   - use su-exec to run the command as a non-root user
#   - which will be run by `tini` which solves the PID 1 problem
#
# For more on the PID 1 problem see:
#   https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/
#   https://engineeringblog.yelp.com/2016/01/dumb-init-an-init-for-docker.html
#
ENTRYPOINT ["su-exec", "node:node", "/sbin/tini", "--"]
