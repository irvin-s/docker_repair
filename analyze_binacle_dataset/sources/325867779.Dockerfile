# ==================================================================
# module list
# ------------------------------------------------------------------
# python        2.7    (apt)
# theano        latest (git)
# mpich       3.1.4
# mpi4py ...... 3.0.0
# ==================================================================

FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \

# ==================================================================
# tools
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        && \

# ==================================================================
# python
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python-pip \
        python-dev \
        && \
    $PIP_INSTALL \
        setuptools \
        pip \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        cloudpickle \
        scikit-learn \
        matplotlib \
        Cython \
        && \

# ==================================================================
# theano
# ------------------------------------------------------------------

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libblas-dev \
        && \

    wget -qO- https://github.com/Theano/libgpuarray/archive/v0.7.6.tar.gz | tar xz -C ~ && \
    cd ~/libgpuarray* && mkdir -p build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          .. && \
    make -j"$(nproc)" install && \
    cd ~/libgpuarray* && \
    python setup.py build && \
    python setup.py install && \

    printf '[global]\nfloatX = float32\ndevice = cuda0\n\n[dnn]\ninclude_path = /usr/local/cuda/targets/x86_64-linux/include\n' > ~/.theanorc && \

    $PIP_INSTALL \
        https://github.com/Theano/Theano/archive/master.zip && \
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# ==================================================================
# mpich3.1.4
# ------------------------------------------------------------------
RUN mkdir /build_file/
RUN cd /build_file && \
       wget http://www.mpich.org/static/downloads/3.1.4/mpich-3.1.4.tar.gz && \
       tar zxf mpich-3.1.4.tar.gz && \
     #  mkdir -p /usr/local/mpich  && \
       cd mpich-3.1.4 && \
       ./configure --disable-fortran && \
       make -j4  && \
       make install && \
       rm -rf /mpich-3.1.4.tar.gz && \

# ==================================================================
# mpi4py3.0.0
# ------------------------------------------------------------------
       cd /build_file && \
       wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.0.tar.gz  && \
       tar xvzf mpi4py-3.0.0.tar.gz  && \
       cd mpi4py-3.0.0  && \
       python setup.py build && \
       python setup.py install --user && \
       rm -rf /mpi4py-3.0.0.tar.gz  && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
