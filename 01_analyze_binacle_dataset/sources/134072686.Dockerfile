FROM ubuntu:14.04
MAINTAINER vlall
LABEL Description="Install Tensorflow, Theano, and Caffe (CPU)" Version="1.0"

RUN apt-get update && apt-get install -y \
    # General install
    build-essential \
    git \
    python \
    python-dev \
    python-pip \
    python-numpy \  
    wget \
    # For Caffe
    libprotobuf-dev \
    libleveldb-dev \
    libsnappy-dev \
    libopencv-dev \
    libhdf5-serial-dev \
    protobuf-compiler \
    --no-install-recommends libboost-all-dev \
    libatlas-base-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblmdb-dev \
    # For Theano
    g++ \
    gfortran \
    libevent-dev
    
RUN mkdir /home/frameworks
WORKDIR /home/frameworks

# Install TensorFlow
RUN pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.7.1-cp27-none-linux_x86_64.whl

# Install Caffe 
RUN git clone https://github.com/BVLC/caffe
WORKDIR /home/frameworks/caffe
RUN cp Makefile.config.example Makefile.config
# We uncomment line in Makefile.config to use CPU version
RUN sed -i '/CPU_ONLY := 1/s/^#//g' Makefile.config
RUN make all
RUN make test
RUN make runtest

# Install Theano
WORKDIR /home/frameworks
RUN pip install Theano

VOLUME ["/deep-cpu/data"]
ENTRYPOINT ["deep-cpu"]
