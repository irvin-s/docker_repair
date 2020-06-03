FROM phusion/baseimage:0.9.19

ENV LANG=en_US.UTF-8

ADD . /usr/local/src/viz

RUN \
    apt-get update && \
    apt-get install -y \
        autoconf \
        automake \
        autotools-dev \
        bsdmainutils \
        build-essential \
        cmake \
        doxygen \
        git \
        ccache\
        libboost-all-dev \
        libreadline-dev \
        libssl-dev \
        libtool \
        ncurses-dev \
        pbzip2 \
        pkg-config \
        python3 \
        python3-dev \
        python3-pip \
    && \
    pip3 install gcovr && \
    # build vizd
    cd /usr/local/src/viz && \
    git submodule deinit -f . && \
    git submodule update --init --recursive -f && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_SHARED_LIBRARIES=FALSE \
        -DLOW_MEMORY_NODE=TRUE \
        -DCHAINBASE_CHECK_LOCKING=FALSE \
        -DENABLE_MONGO_PLUGIN=FALSE \
        .. \
    && \
    make -j$(nproc) && \
    make install && \
    # perform cleanup
    rm -rf /usr/local/src/viz && \
    apt-get remove -y \
        automake \
        autotools-dev \
        bsdmainutils \
        build-essential \
        cmake \
        doxygen \
        dpkg-dev \
        git \
        libboost-all-dev \
        libc6-dev \
        libexpat1-dev \
        libgcc-5-dev \
        libhwloc-dev \
        libibverbs-dev \
        libicu-dev \
        libltdl-dev \
        libncurses5-dev \
        libnuma-dev \
        libopenmpi-dev \
        libpython-dev \
        libpython2.7-dev \
        libreadline-dev \
        libreadline6-dev \
        libssl-dev \
        libstdc++-5-dev \
        libtinfo-dev \
        libtool \
        linux-libc-dev \
        m4 \
        make \
        manpages \
        manpages-dev \
        mpi-default-dev \
        python-dev \
        python2.7-dev \
        python3-dev \
    && \
    apt-get autoremove -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /var/cache/* \
        /usr/include \
        /usr/local/include && \
    # add pseudouser
    useradd -s /bin/bash -m -d /var/lib/vizd vizd && \
    # prepare cache directory
    mkdir /var/cache/vizd && \
    chown vizd:vizd -R /var/cache/vizd

# add blockchain cache to image
#ADD $VIZD_BLOCKCHAIN /var/cache/vizd/blocks.tbz2

ENV HOME /var/lib/vizd
RUN chown vizd:vizd -R /var/lib/vizd

ADD share/vizd/snapshot.json /var/lib/vizd

# rpc service:
# http
EXPOSE 8090
# ws
EXPOSE 8091
# p2p service:
EXPOSE 2001

RUN mkdir -p /etc/service/vizd
ADD share/vizd/vizd.sh /etc/service/vizd/run
RUN chmod +x /etc/service/vizd/run

# add seednodes from documentation to image
ADD share/vizd/seednodes /etc/vizd/seednodes

# the following adds lots of logging info to stdout
ADD share/vizd/config/config.ini /etc/vizd/config.ini
