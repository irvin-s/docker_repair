FROM i386/ubuntu:16.04

# install packages
RUN apt-get update -y && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:valhalla-core/valhalla && apt-get update -y

RUN apt-get install -y autoconf automake make libtool pkg-config g++ gcc jq lcov locales coreutils protobuf-compiler vim-common ccache clang-tidy-5.0 clang-5.0 git osmium-tool curl
RUN apt-get install -y libboost-all-dev libcurl4-openssl-dev libgeos-dev libgeos++-dev liblua5.2-dev prime-server0.6.3-bin libprime-server0.6.3-dev libprotobuf-dev libsqlite3-mod-spatialite libspatialite-dev libsqlite3-dev zlib1g-dev liblz4-dev
RUN apt-get install -y python-minimal python-all-dev python3-minimal python3-all-dev lua5.2


# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.3

# install node
RUN mkdir -p ${NVM_DIR}
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


# install cmake
ADD https://cmake.org/files/v3.11/cmake-3.11.2-Linux-x86_64.sh /tmp/cmake.sh
RUN sh /tmp/cmake.sh --prefix=/usr/local --skip-license && /bin/rm /tmp/cmake.sh
RUN cmake --version


# set paths
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lib:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:/lib32:/usr/lib32
