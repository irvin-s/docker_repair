FROM ubuntu:14.04
MAINTAINER caffe-maint@googlegroups.com

#RUN apt-get update && apt-get install -y --no-install-recommends \
RUN apt-get update && apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
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
        protobuf-compiler \
        python-dev \
        python-numpy \
        python-pip \
	python-tk \
	emacs \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: clone a specific git tag and use ARG instead of ENV once DockerHub supports this.
ENV CLONE_TAG=master

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR /opt/caffe/models
COPY faster_rcnn_models.tgz /opt/caffe/models 
COPY 00-classification.py   /opt/caffe/examples
COPY 00-faster.py   /opt/caffe/examples
RUN tar zxvf faster_rcnn_models.tgz && \
    rm faster_rcnn_models.tgz && \
    ../scripts/download_model_binary.py ./bvlc_reference_caffenet
RUN  ../data/ilsvrc12/get_ilsvrc_aux.sh
#RUN apt-get  install python-tk
WORKDIR $CAFFE_ROOT