FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
    python-dev \
    python-pip \
    wget \
    git \
    cmake \
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libhdf5-serial-dev \
    protobuf-compiler \
    libboost-all-dev \
    libatlas-base-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev

# install tensorflow, keras and other dependencies
RUN pip install \
    numpy \
    scipy \
    pandas \
    Pillow \
    requests \
    arrow \
    tensorflow==1.0.1 \
    Keras==1.1.1

WORKDIR /root

# install caffe
RUN git clone --branch rc5 https://github.com/BVLC/caffe.git && \
    cd caffe && \
    cat python/requirements.txt | xargs -n1 pip install && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j"$(nproc)" all && \
    make install
ENV PYTHONPATH=/root/caffe/python:$PYTHONPATH

# compressed textures tools
RUN apt-get install -y libnvtt-bin
RUN cd && \
    wget https://github.com/oxygine/oxygine-framework/raw/master/3rdPartyTools/linux/PVRTexToolCLI && \
    chmod +x ~/PVRTexToolCLI

# clone git repo bengler propinquity
RUN git clone https://github.com/bengler/propinquity.git

RUN ["/bin/bash"]
