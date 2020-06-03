FROM ubuntu:16.04 as root-build
LABEL maintainer caffe-maint@googlegroups.com
RUN apt-get update && apt-get install -y --no-install-recommends \
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
        python-setuptools \
	python-matplotlib \
	python-pil \
	cython \
	python-skimage \
        python-scipy && \
    rm -rf /var/lib/apt/lists/*

FROM golang:alpine AS build
RUN apk add git
ADD . /go/src/github.com/stefanolsenn/nsfw 
WORKDIR /go/src/github.com/stefanolsenn/nsfw
#disable crosscompiling 
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux

#build the binary with debug information removed
RUN go get -d -v
RUN go build -ldflags '-w -s' -a -installsuffix cgo -o /go/bin/github.com/stefanolsenn/nsfw

FROM root-build
COPY --from=build /go/bin/github.com/stefanolsenn/nsfw /go/bin/github.com/stefanolsenn/nsfw
ADD . /workspace
##ADD classify_nsfw.py /go/bin/github.com/stefanolsenn/nsfw
ENV CAFFE_ROOT=/opt/caffe
WORKDIR $CAFFE_ROOT

# FIXME: use ARG instead of ENV once DockerHub supports this
# https://github.com/docker/hub-feedback/issues/460
ENV CLONE_TAG=1.0

RUN git clone -b ${CLONE_TAG} --depth 1 https://github.com/BVLC/caffe.git . && \
    pip install && pip install requests && \
    cd python && for req in $(cat requirements.txt) pydot; do pip install $req; done && cd .. && \
    mkdir build && cd build && \
    cmake -DCPU_ONLY=1 .. && \
    make -j"$(nproc)"

ENV PYCAFFE_ROOT $CAFFE_ROOT/python
ENV PYTHONPATH $PYCAFFE_ROOT:$PYTHONPATH
ENV PATH $CAFFE_ROOT/build/tools:$PYCAFFE_ROOT:$PATH
RUN echo "$CAFFE_ROOT/build/lib" >> /etc/ld.so.conf.d/caffe.conf && ldconfig

WORKDIR /workspace
ENTRYPOINT ["/go/bin/github.com/stefanolsenn/nsfw"]
#ENTRYPOINT ["/bin/sh"]
