FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y wget make pkg-config gcc xz-utils zlib1g-dev librsvg2-dev libxml2-dev libpango1.0-dev libcairo2-dev libcroco3-dev libgirepository1.0-dev
