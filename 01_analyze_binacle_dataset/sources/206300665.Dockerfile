FROM mesos-build
MAINTAINER Kevin Klues <klueska@mesosphere.com>

RUN git reset --hard HEAD && \
    git checkout master && \
    git pull

RUN cd build && \
    make -j install
