FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    bzip2 \
    ca-certificates \
    cmake \
    git \
    libatlas-base-dev \
    libboost-all-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libprotobuf-dev \
    libsnappy-dev \
    locales \
    netcat \
    protobuf-compiler \
    python3-dev \
    python3-numpy \
    python3-pip \
    python3-pydot \
    python3-scipy \
    python3-setuptools \
    sudo \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install pip==9.0.3 \
    && pip3 install -U \
    cython \
    h5py \
    ipython \
    jupyter \
    leveldb \
    lmdb \
    matplotlib \
    networkx \
    nose \
    numpy \
    pandas \
    Pillow \
    protobuf \
    pydot \
    python-dateutil \
    python-gflags \
    pyyaml \
    scikit-image \
    scipy \
    six \
    && rm -rf ~/.cache/pip

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

ENV CLONE_TAG=1.0

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . \
    && mkdir build \
    && cd build \
    && cmake -DCPU_ONLY=1 -Dpython_version=3 .. \
    && make -j$(nproc)

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo '$CAFFE_ROOT/build/lib' >> /etc/ld.so.conf.d/caffe.conf \
    && ldconfig

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Install Tini
RUN wget --quiet https://github.com/krallin/tini/releases/download/v0.10.0/tini && \
    echo "1361527f39190a7338a0b434bd8c88ff7233ce7b9a4876f3315c22fce7eca1b0 *tini" | sha256sum -c - && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Configure environment
ENV SHELL=/bin/bash \
    NB_USER=aurora \
    NB_UID=1000 \
    NB_GID=2000 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

# Create aurora user with UID=1000 and in the 'aurora' group
RUN groupadd -g $NB_GID $NB_USER \
    && useradd -m -s $SHELL -N -u $NB_UID -g $NB_GID $NB_USER \
    && echo '%'$NB_USER 'ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

EXPOSE 8888
WORKDIR /workspace

# Add local files as late as possible to avoid cache busting
COPY start.sh /usr/local/bin/
COPY start-notebook.sh /usr/local/bin/
COPY jupyter_notebook_config.py /etc/jupyter/

# Install Aurora job submit tool
ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi

# Configure container startup
ENTRYPOINT ["tini", "--"]
CMD ["start-notebook.sh"]
