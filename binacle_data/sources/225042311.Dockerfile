FROM ubuntu:15.10
MAINTAINER Jens Ravens

RUN apt-get install -y wget
RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key| apt-key add -
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import -
RUN gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
RUN apt-get update

ADD swift /var/build
ENV SWIFT swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10
RUN gpg --verify /var/build/$SWIFT.tar.gz.sig
RUN cd /var/build && tar xzf $SWIFT.tar.gz && mv $SWIFT ../swift && rm -rf /var/build

RUN apt-get install -y build-essential libclang1 libpython2.7 libicu55 clang-3.7 git cmake ninja-build clang uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config

RUN ls /var/swift
ENV PATH /var/swift/usr/bin:$PATH
