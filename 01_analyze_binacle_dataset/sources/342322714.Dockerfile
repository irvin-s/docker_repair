FROM ubuntu:16.04
MAINTAINER Grigori Fursin <Grigori.Fursin@cTuning.org>

# Install standard packages.
RUN apt-get update && apt-get install -y \
    python-all \
    python-pip \
    git zip bzip2 sudo wget \
    libglib2.0-0 libsm6

RUN pip install ck
RUN ck  version

# Install CK RPi repo
RUN ck pull repo:ck-request-asplos18-caffe-intel
RUN ck pull repo:ck-request-asplos18-results-caffe-intel

# Install necessary packages

RUN ck install package:lib-gflags-2.2.0
RUN ck install package:lib-glog-0.3.5
RUN ck install package:lib-opencv-3.3.0
RUN ck install package:lib-boost-1.64.0-min-for-caffe

# Non-intel compiler build to convert next packages to LMDB
# Install and detect your Intel compilers later 
# and build a new version with ICC ...
RUN ck install package:lib-caffe-intel-request-cpu

RUN ck install package:imagenet-2012-val-min

RUN echo "500\n" | ck install ck-caffe:package:imagenet-2012-val-lmdb-224
RUN echo "\n" | ck install ck-caffe:package:caffemodel-resnet50
RUN echo "\n" | ck install ck-request-asplos18-caffe-intel:package:caffemodel-resnet50-intel-i8

RUN echo "500\n" | ck install ck-caffe:package:imagenet-2012-val-lmdb-320
RUN echo "\n" | ck install ck-caffe:package:caffemodel-inception-v3
RUN echo "\n" | ck install ck-request-asplos18-caffe-intel:package:caffemodel-inception-v3-intel-i8

RUN echo "\n" | ck install package:caffemodel-ssd-voc-300

# command line
CMD bash
