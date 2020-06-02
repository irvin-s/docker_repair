FROM reggaemuffin/steem-baseimage:latest

ENV LANG=en_US.UTF-8

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
        gdb \
        git \
        libboost-all-dev \
        libyajl-dev \
        libreadline-dev \
        libssl-dev \
        libtool \
        liblz4-tool \
        ncurses-dev \
        pkg-config \
        python3 \
        python3-dev \
        python3-jinja2 \
        python3-pip \
        nginx \
        fcgiwrap \
        awscli \
        jq \
        wget \
        virtualenv \
        gdb \
        libgflags-dev \
        libsnappy-dev \
        zlib1g-dev \
        libbz2-dev \
        liblz4-dev \
        libzstd-dev \
        lcov \
        ruby \
        ccache \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 install gcovr && \
    gem install mtime_cache

ADD . /usr/local/src/steem

RUN cd /usr/local/src/steem && git submodule update --init --recursive && sh ciscripts/compiletest.sh && \
    cd /usr/local/src/steem/build && \
    ./tests/chain_test && \
    ./tests/plugin_test && \
    cd .. && \
    sh ./ciscripts/collectcoverage.sh && \
    cd build && \
    ./programs/util/test_fixed_string && \
    cd /usr/local/src/steem && \
    programs/build_helpers/get_config_check.sh && \
    doxygen && \
    PYTHONPATH=programs/build_helpers \
    python3 -m steem_build_helpers.check_reflect && \
    mkdir -p /usr/local/src/steemtmp && \
    mv /usr/local/src/steem/build /usr/local/src/steemtmp && \
    mv /usr/local/src/steem/.mtime_cache /usr/local/src/steemtmp && \
    mv /usr/local/src/steem/.ccache /usr/local/src/steemtmp && \
    mv /usr/local/src/steem/coverage.info /usr/local/src/steemtmp && \
    rm -rf /usr/local/src/steem

RUN \
    apt-get remove -y \
        autoconf \
        automake \
        autotools-dev \
        bsdmainutils \
        build-essential \
        cmake \
        doxygen \
        gdb \
        git \
        libboost-all-dev \
        libyajl-dev \
        libreadline-dev \
        libssl-dev \
        libtool \
        liblz4-tool \
        ncurses-dev \
        pkg-config \
        python3 \
        python3-dev \
        python3-jinja2 \
        python3-pip \
        nginx \
        fcgiwrap \
        awscli \
        jq \
        wget \
        virtualenv \
        gdb \
        libgflags-dev \
        libsnappy-dev \
        zlib1g-dev \
        libbz2-dev \
        liblz4-dev \
        libzstd-dev \
        lcov \
        ruby \
        ccache \
    && \
    apt-get autoremove -y && \
    rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
        /var/cache/* \
        /usr/include \
        /usr/local/include
