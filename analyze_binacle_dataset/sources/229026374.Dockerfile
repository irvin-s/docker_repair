# Test an Apple Swift build with the Linux buildbot preset using a
# using a codebase provided in a Volume.

FROM ubuntu:16.04

MAINTAINER https://github.com/eosrei/docker-swift-dev-buildbot

# Volume mounted from host to access source code. [Required]
VOLUME ["/src"]
# Volume to store compiled package and build log. [Optional]
VOLUME ["/output"]

# Where build-script will store the build files
ENV SWIFT_BUILD_ROOT /build

COPY build.sh /root/build.sh

# Note: git config required for swiftpm/Tests/dep/FunctionalBuildTests.swift
RUN buildDeps='git cmake ninja-build uuid-dev icu-devtools libbsd-dev libtool \
      libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev autoconf \
      libncurses5-dev pkg-config ca-certificates python rsync file'; \
      runDeps='libicu-dev clang'; \
    apt-get update \
    && apt-get -y install $buildDeps $runDeps --no-install-recommends \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && git config --global user.email "root@example.com" \
    && git config --global user.name "Root" \
    && chmod +x /root/build.sh

CMD ["/root/build.sh"]
