
FROM ubuntu:18.04

LABEL Description="This image contains tools used to build opentxs" Vendor="OpenTransactions"

ARG BUILD_PACKAGES="\
    build-essential \
    checkinstall \
    g++-8 \
    gcc-8 \
    time \
    xz-utils \
"

ARG GIT_PACKAGES="\
    ca-certificates \
    git \
"

# Include `cmake-curses-gui` if you're working interactively.

ARG CMAKE_PACKAGES="\
    cmake \
"
ARG LOCAL_BUILD_TOOLS="\
    doxygen \
    graphviz \
    libboost-all-dev \
    libgtest-dev \
    liblmdb-dev \
    libprotobuf-dev \
    libsecp256k1-dev \
    libsodium-dev \
    libssl-dev \
    libzmq3-dev \
    protobuf-compiler \
    python3 \
    python3-dev \
    python3-protobuf \
    python3-setuptools \
    python3-wheel \
    time \
"

ARG ALL_PACKAGES="\
    $BUILD_PACKAGES \
    $GIT_PACKAGES \
    $CMAKE_PACKAGES \
    $LOCAL_BUILD_TOOLS \
"

RUN apt-get update -q && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install --yes --no-install-recommends $ALL_PACKAGES

# build-essential installs gcc-7 and g++-7. Select gcc-8 as
# `/usr/bin/gcc` and g++-8 as `/usr/bin/g++`
#
# Via https://askubuntu.com/questions/1028601/install-gcc-8-only-on-ubuntu-18-04

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 700 --slave /usr/bin/g++ g++ /usr/bin/g++-7
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8

# gtest:

ARG MAKE_PARALLEL=-j
WORKDIR /usr/src/gtest/build
RUN time -p bash -c "cmake .. && make ${MAKE_PARALLEL} && make install"

VOLUME /src
WORKDIR /src

#COPY CMakeLists.txt cmake deps include src tests wrappers ./
#RUN mkdir build 
#RUN cd build && cmake -DBUILD_VERBOSE=OFF ..
#RUN time -p bash -c "make ${MAKE_PARALLEL} && make install"
#RUN echo "--------- TIMING INFORMATION FOR OPENTXS BUILD"
#RUN make test

