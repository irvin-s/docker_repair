FROM nvidia/cuda:8.0-cudnn5-devel-centos7
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum update -y && yum install -y epel-release && \
    yum -y group install "Development Tools" && yum install -y \
    cmake \
    git \
    wget \
    openblas-devel \
    python-devel \
    python-pip \
    numpy \
    scipy \
    vim

RUN pip install --upgrade pip \
    pydicom

ENV TENSORFLOW_VERSION 0.11.0rc2
RUN pip --no-cache-dir install \
    http://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl
