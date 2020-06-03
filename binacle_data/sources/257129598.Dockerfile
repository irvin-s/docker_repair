FROM ubuntu:14.04
ENV SWIFT_BRANCH swift-3.0-release
ENV SWIFT_VERSION swift-3.0-RELEASE 
ENV SWIFT_PLATFORM ubuntu14.04
ENV DEPENDENCY_PACKAGES=""
ENV BUILD_PACKAGES="build-essential wget clang-3.6 curl libedit-dev python2.7 python2.7-dev libicu52 rsync libxml2 git libcurl4-openssl-dev uuid-dev"
# Install related packages and set LLVM 3.6 as the compiler
RUN apt-get clean &&\
    apt-get -y update && \
    apt-get -y dist-upgrade && \
    apt-get install -y $DEPENDENCY_PACKAGES $BUILD_PACKAGES && \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-3.6 100 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-3.6 100 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# Install Swift keys
RUN wget -q -O - https://swift.org/keys/all-keys.asc | gpg --import - && \
    gpg --keyserver hkp://pool.sks-keyservers.net --refresh-keys Swift
# Install Swift Ubuntu 14.04 Snapshot
RUN SWIFT_ARCHIVE_NAME=$SWIFT_VERSION-$SWIFT_PLATFORM && \
    SWIFT_URL=https://swift.org/builds/$SWIFT_BRANCH/$(echo "$SWIFT_PLATFORM" | tr -d .)/$SWIFT_VERSION/$SWIFT_ARCHIVE_NAME.tar.gz && \
    wget $SWIFT_URL && \
    wget $SWIFT_URL.sig && \
    gpg --verify $SWIFT_ARCHIVE_NAME.tar.gz.sig && \
    tar -xvzf $SWIFT_ARCHIVE_NAME.tar.gz --directory / --strip-components=1 && \
    rm -rf $SWIFT_ARCHIVE_NAME* /tmp/* /var/tmp/*
# Set Swift Path
ENV PATH /usr/bin:$PATH
# Repo clone
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp
# Build
RUN swift build --build-path ./build
