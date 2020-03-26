# This Dockerfile is used for running integration tests for the processor

FROM ubuntu:xenial

RUN apt-get update && apt-get install -y gnupg

RUN echo "deb http://repo.sawtooth.me/ubuntu/1.0/stable xenial universe" >> /etc/apt/sources.list && \
    (apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8AA7AF1F1091A5FD || \
    apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 8AA7AF1F1091A5FD) && \
    apt-get update

RUN apt-get install -y --allow-unauthenticated -q \
    python3 \
    python3-pip \
    python3-sawtooth-cli \
    python3-sawtooth-sdk \
    python3-sawtooth-signing

RUN pip3 install \
    grpcio-tools \
    nose2

ENV PATH=$PATH:/project/cert_registry/bin

ENV PYTHONPATH=$PYTHONPATH:/project/cert_registry/integration_tests

WORKDIR /project/cert_registry
