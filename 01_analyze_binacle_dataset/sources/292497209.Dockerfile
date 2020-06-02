FROM ubuntu:16.04
LABEL maintainer cpfs@clustertech.com
RUN apt-get update && \
    apt-get install -y \
      attr \
      cmake \
      fuse \
      g++ \
      libattr1-dev \
      libboost-dev \
      libboost-atomic-dev \
      libboost-date-time-dev \
      libboost-filesystem-dev \
      libboost-program-options-dev \
      libboost-random-dev \
      libboost-system-dev \
      libboost-thread-dev \
      libbotan1.10-dev \
      libexpat-dev \
      libfuse-dev \
      pkg-config \
      unzip \
      vim \
      wget
RUN useradd -m builder && usermod -a -G audio builder
ADD . /home/builder/
RUN chown -R builder.builder /home/builder/
USER builder
RUN cd && \
    ./build_dep
RUN cd && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make -j 6 -l 4 && \
    make DESTDIR=install install && \
    make package && \
    mkdir package && \
    mv cpfs-os* package
