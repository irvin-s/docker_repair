FROM tensorflow-serving-devel:latest

RUN apt-get update && apt-get install -y \
        cmake \
        libboost-thread-dev \
        libboost-system-dev \ 
        libboost-filesystem-dev \
        libboost-python-dev \
        libpython-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-dev \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# OpenBLAS
RUN cd /opt && \
    curl -L -O https://github.com/xianyi/OpenBLAS/archive/v0.2.18.zip && \
    unzip -a v0.2.18.zip && \
    cd OpenBLAS-0.2.18 && \
    make HOSTCC=gcc TARGET=HASWELL USE_OPENMP=0 USE_THREAD=0 NO_LAPACKE=1 ONLY_CBLAS=1 BINARY=64 && \
    make install PREFIX=/opt/OpenBLAS && \
    cd .. && \
    rm v0.2.18.zip && \
    rm -rf OpenBLAS-0.2.18

CMD ["/bin/bash"]