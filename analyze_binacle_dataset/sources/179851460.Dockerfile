FROM ubuntu:trusty

RUN apt-get update && \
    apt-get install -y build-essential nasm genisoimage && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /code
