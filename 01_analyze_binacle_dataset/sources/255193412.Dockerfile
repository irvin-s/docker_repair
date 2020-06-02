FROM nvidia/cuda:8.0-cudnn5-devel-centos7
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum update -y && yum install -y epel-release && \
    yum -y group install "Development Tools" && yum install -y \
    cmake \
    git \
    wget \
    openblas-devel \
    protobuf-devel \
    leveldb-devel \
    snappy-devel \
    opencv-devel \
    boost-devel \
    hdf5-devel \
    gflags-devel \
    glog-devel \
    lmdb-devel \
    freetype-devel \
    libpng-devel \
    python-devel \
    python-pip \
    numpy \
    scipy \
    vim

RUN pip install --upgrade pip \
    pydicom

ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

ENV CLONE_TAG=master
RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git .
# Modified verion of convert_imageset to remove an image file after having added it to the DB (use --rmi).
COPY src/caffe/tools/convert_imageset.cpp tools/.
RUN for req in $(cat python/requirements.txt) pydot; do pip install $req; done && \
    mkdir build && cd build && \
    cmake -DBLAS=Open -DUSE_CUDNN=1 .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig
