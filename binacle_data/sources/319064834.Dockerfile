FROM phusion/baseimage:0.9.19

ARG CONTENTOS_STATIC_BUILD=ON
ENV CONTENTOS_STATIC_BUILD ${CONTENTOS_STATIC_BUILD}

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
        git \
        libboost-all-dev \
        libreadline-dev \
        libssl-dev \
        libtool \
        ncurses-dev \
        pbzip2 \
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
        gdb \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip3 install gcovr

ADD . /usr/local/src/contentos

RUN \
    cd /usr/local/src/contentos && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_CONTENTOS_TESTNET=ON \
        -DLOW_MEMORY_NODE=OFF \
        -DCLEAR_VOTES=ON \
        -DSKIP_BY_TX_ID=ON \
        .. && \
    make -j$(nproc) test_fixed_string && \
    ./programs/util/test_fixed_string && \
    cd /usr/local/src/contentos && \
    doxygen && \
#    programs/build_helpers/check_reflect.py && \
#    programs/build_helpers/get_config_check.sh && \
    rm -rf /usr/local/src/contentos/build

RUN \
    cd /usr/local/src/contentos && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_BUILD_TYPE=Debug \
        -DENABLE_COVERAGE_TESTING=ON \
        -DBUILD_CONTENTOS_TESTNET=ON \
        -DLOW_MEMORY_NODE=OFF \
        -DCLEAR_VOTES=ON \
        -DSKIP_BY_TX_ID=ON \
        -DCHAINBASE_CHECK_LOCKING=OFF \
        .. && \
    mkdir -p /var/cobertura && \
    gcovr --object-directory="../" --root=../ --xml-pretty --gcov-exclude=".*tests.*" --gcov-exclude=".*fc.*" --gcov-exclude=".*app*" --gcov-exclude=".*net*" --gcov-exclude=".*plugins*" --gcov-exclude=".*schema*" --gcov-exclude=".*time*" --gcov-exclude=".*utilities*" --gcov-exclude=".*wallet*" --gcov-exclude=".*programs*" --output="/var/cobertura/coverage.xml" && \
    cd /usr/local/src/contentos && \
    rm -rf /usr/local/src/contentos/build

RUN \
    cd /usr/local/src/contentos && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local/contentosd-default \
        -DCMAKE_BUILD_TYPE=Release \
#        -DLOW_MEMORY_NODE=ON \
#        -DCLEAR_VOTES=ON \
#        -DSKIP_BY_TX_ID=OFF \
        -DBUILD_CONTENTOS_TESTNET=OFF \
        -DCONTENTOS_STATIC_BUILD=${CONTENTOS_STATIC_BUILD} \
        .. \
    && \
    make -j$(nproc) && \
    make install && \
    cd .. && \
    ( /usr/local/contentosd-default/bin/contentosd --version \
      | grep -o '[0-9]*\.[0-9]*\.[0-9]*' \
      && echo '_' \
      && git rev-parse --short HEAD ) \
      | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n//g' \
      > /etc/contentosdversion && \
    cat /etc/contentosdversion && \
    rm -rfv build && \
    mkdir build && \
    cd build && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/usr/local/contentosd-full \
        -DCMAKE_BUILD_TYPE=Release \
        -DLOW_MEMORY_NODE=OFF \
        -DCLEAR_VOTES=OFF \
        -DSKIP_BY_TX_ID=ON \
        -DBUILD_CONTENTOS_TESTNET=OFF \
        -DCONTENTOS_STATIC_BUILD=${CONTENTOS_STATIC_BUILD} \
        .. \
    && \
    make -j$(nproc) && \
    make install && \
    rm -rf /usr/local/src/contentos

RUN \
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
        /usr/local/include

RUN useradd -s /bin/bash -m -d /var/lib/contentosd contentosd

RUN mkdir /var/cache/contentosd && \
    chown contentosd:contentosd -R /var/cache/contentosd

ENV HOME /var/lib/contentosd
RUN chown contentosd:contentosd -R /var/lib/contentosd

VOLUME ["/var/lib/contentosd"]

# rpc service:
EXPOSE 8090
# p2p service:
EXPOSE 2001

# add seednodes from documentation to image
ADD doc/seednodes.txt /etc/contentosd/seednodes.txt

# the following adds lots of logging info to stdout
ADD contrib/config-for-docker.ini /etc/contentosd/config.ini
ADD contrib/fullnode.config.ini /etc/contentosd/fullnode.config.ini
ADD contrib/config-for-broadcaster.ini /etc/contentosd/config-for-broadcaster.ini
ADD contrib/config-for-ahnode.ini /etc/contentosd/config-for-ahnode.ini

# add normal startup script that starts via sv
ADD contrib/contentosd.run /usr/local/bin/contentos-sv-run.sh
RUN chmod +x /usr/local/bin/contentos-sv-run.sh

# add nginx templates
ADD contrib/contentosd.nginx.conf /etc/nginx/contentosd.nginx.conf
ADD contrib/healthcheck.conf.template /etc/nginx/healthcheck.conf.template

# add PaaS startup script and service script
ADD contrib/startpaascontentosd.sh /usr/local/bin/startpaascontentosd.sh
ADD contrib/paas-sv-run.sh /usr/local/bin/paas-sv-run.sh
ADD contrib/sync-sv-run.sh /usr/local/bin/sync-sv-run.sh
ADD contrib/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/startpaascontentosd.sh
RUN chmod +x /usr/local/bin/paas-sv-run.sh
RUN chmod +x /usr/local/bin/sync-sv-run.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

# new entrypoint for all instances
# this enables exitting of the container when the writer node dies
# for PaaS mode (elasticbeanstalk, etc)
# AWS EB Docker requires a non-daemonized entrypoint
ADD contrib/contentosdentrypoint.sh /usr/local/bin/contentosdentrypoint.sh
RUN chmod +x /usr/local/bin/contentosdentrypoint.sh
CMD /usr/local/bin/contentosdentrypoint.sh
