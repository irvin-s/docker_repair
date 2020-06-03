FROM ubuntu:xenial
RUN apt-get update && apt-get install strace --no-install-recommends -y && rm -rf /var/lib/apt/lists/*
