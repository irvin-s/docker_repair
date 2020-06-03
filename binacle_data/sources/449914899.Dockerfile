FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get -y install curl tree g++ gcc libc6-dev libffi-dev libgmp-dev git make zlib1g-dev
RUN apt-get -y install build-essential xz-utils

RUN curl -sSL https://get.haskellstack.org/ | sh

ADD . /hgit-build
RUN cd /hgit-build && stack build --only-dependencies
RUN cd /hgit-build && stack build
RUN cd /hgit-build && stack build --copy-bins && mv /root/.local/bin/hgit /bin
ENV PATH /root/.local/bin:$PATH
