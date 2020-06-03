FROM ubuntu:16.04

RUN apt-get update && apt-get install -y nano wget git sudo

RUN apt-get install -y python-pyopencl python-pyopencl-doc clinfo

WORKDIR /root

