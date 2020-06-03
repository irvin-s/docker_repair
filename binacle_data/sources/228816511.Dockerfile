FROM ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive

RUN \
  apt-get update && \
  apt-get install -y git cmake ninja-build clang uuid-dev libicu-dev icu-devtools libbsd-dev libedit-dev libxml2-dev libsqlite3-dev swig libpython-dev libncurses5-dev pkg-config && \
  rm -rf /var/lib/apt/lists/*

RUN \
  git clone --depth=1 https://github.com/apple/swift.git swift && \
  git clone --depth=1 https://github.com/apple/swift-llvm.git llvm && \
  git clone --depth=1 https://github.com/apple/swift-clang.git clang && \
  git clone --depth=1 https://github.com/apple/swift-lldb.git lldb && \
  git clone --depth=1 https://github.com/apple/swift-cmark.git cmark && \
  git clone --depth=1 https://github.com/apple/swift-llbuild.git llbuild && \
  git clone --depth=1 https://github.com/apple/swift-package-manager.git swiftpm && \
  git clone --depth=1 https://github.com/apple/swift-corelibs-xctest.git && \
  git clone --depth=1 https://github.com/apple/swift-corelibs-foundation.git

RUN \
  ./swift/utils/build-script
