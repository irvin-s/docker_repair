FROM mesos-base
MAINTAINER Kevin Klues <klueska@mesosphere.com>

RUN rm -rf build && \
    mkdir -p build && \
    ./bootstrap && \
    cd build && \
    ../configure && \
    make -j install
