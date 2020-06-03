FROM node:9-stretch

RUN apt-get update \
    && apt-get install -y --no-install-recommends maven default-jdk curl git \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*
