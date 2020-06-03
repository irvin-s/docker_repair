FROM nvidia/cuda:7.5-cudnn4-devel-centos7
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

# Repository for recent packages
#
# Needed for gflags-devel, among others
RUN yum -y install epel-release && yum clean all

ENV CUDA_DRIVER_VERSION=352.79
# You may need to change the driver version
RUN yum -y install \
    xorg-x11-drv-nvidia-libs-$CUDA_DRIVER_VERSION \
    yum-versionlock \
    && yum -y install \
    xorg-x11-drv-nvidia-$CUDA_DRIVER_VERSION \
    xorg-x11-drv-nvidia-devel-$CUDA_DRIVER_VERSION \
    xorg-x11-drv-nvidia-gl-$CUDA_DRIVER_VERSION \
    cuda-drivers-$CUDA_DRIVER_VERSION \
    && yum clean all \
    && yum versionlock \
    cuda-drivers \
    xorg-x11-drv-nvidia \
    xorg-x11-drv-nvidia-devel \
    xorg-x11-drv-nvidia-gl \
    xorg-x11-drv-nvidia-libs

# Common needed packages
RUN yum -y install \
    autoconf \
    automake \
    boost-devel \
    cuda-runtime-7-5 \
    libtool \
    bzip2 \
    git \
    gflags-devel \
    glog-devel \
    hdf5-devel \
    leveldb-devel \
    lmdb-devel \
    libuuid-devel \
    make \
    numactl-devel \
    opencv-devel \
    openblas-devel \
    protobuf-devel \
    psmisc \
    snappy-devel \
    wget \
    which \
    && yum clean all

