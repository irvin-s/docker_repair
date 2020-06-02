# syntax = docker/dockerfile:experimental
FROM debian:9 AS updater

RUN rm -f /etc/apt/apt.conf.d/docker-clean
RUN echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt update

FROM debian:9 AS figlet

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt install -y figlet

FROM debian:9 AS gcc

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt \
    apt install -y gcc
