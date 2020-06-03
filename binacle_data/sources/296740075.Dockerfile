FROM ubuntu:16.04

RUN apt update && apt-get install -y \
build-essential \
libfuse-dev \
cmake

