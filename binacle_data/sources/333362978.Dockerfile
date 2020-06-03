#| This Dockerfile provides a starting point for a ROCm installation of math & DL libs.
FROM ubuntu:xenial-20170619
MAINTAINER Jeff Poznanovic <jeffrey.poznanovic@amd.com>

ARG DEB_ROCM_REPO=http://repo.radeon.com/rocm/apt/debian/
ARG ROCM_PATH=/opt/rocm

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /root/

RUN apt update && apt install -y wget software-properties-common 

# Add rocm repository
RUN apt-get clean all
RUN wget -qO - $DEB_ROCM_REPO/rocm.gpg.key | apt-key add -
RUN sh -c  "echo deb [arch=amd64] $DEB_ROCM_REPO xenial main > /etc/apt/sources.list.d/rocm.list"

# Install misc pkgs
RUN apt-get update --allow-insecure-repositories && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  clang-3.8 \
  clang-format-3.8 \
  clang-tidy-3.8 \
  cmake \
  cmake-qt-gui \
  ssh \
  curl \
  apt-utils \
  pkg-config \
  g++-multilib \
  git \
  libunwind-dev \
  libfftw3-dev \
  libelf-dev \
  libncurses5-dev \
  libpthread-stubs0-dev \
  vim \
  gfortran \
  libboost-program-options-dev \
  libssl-dev \
  libboost-dev \
  libboost-system-dev \
  libboost-filesystem-dev \
  rpm \
  libnuma-dev \
  wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install rocm pkgs
RUN apt-get update --allow-insecure-repositories && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    rocm-dev rocm-libs rocm-utils \
    rocfft miopen-hip miopengemm rocblas hipblas rocrand \
    rocm-profiler cxlactivitylogger && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HCC_HOME=$ROCM_PATH/hcc
ENV HIP_PATH=$ROCM_PATH/hip
ENV OPENCL_ROOT=$ROCM_PATH/opencl
ENV PATH="$HCC_HOME/bin:$HIP_PATH/bin:${PATH}"
ENV PATH="$ROCM_PATH/bin:${PATH}"
ENV PATH="$OPENCL_ROOT/bin:${PATH}"
ADD ./docker/ubuntu-16.04-rocm/target.lst /opt/rocm/bin
 
# Setup environment variables, and add those environment variables at the end of ~/.bashrc 
ARG HCC_HOME=/opt/rocm/hcc
ARG HIP_PATH=/opt/rocm/hip
ARG PATH=$HCC_HOME/bin:$HIP_PATH/bin:$PATH


WORKDIR $HOME
ENV HOME /rocm-caffe2
ENV MIOPEN_DISABLE_CACHE 1

# Required system packages to build hipcaffe on UB16.04:
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    pkg-config \
    libgoogle-glog-dev \
    libgtest-dev \
    libiomp-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libopenmpi-dev \
    libsnappy-dev \
    libprotobuf-dev \
    openmpi-bin \
    openmpi-doc \
    protobuf-compiler \
    python-dev \
    python-pip \                  
    python-numpy python-scipy python3-dev python-yaml python-matplotlib\
    libfftw3-dev \
    libelf-dev

RUN pip install \
    future \
    numpy \
    protobuf \
    future \
    pydot \
    opencv-python \ 
    hypothesis \
    pytest \
    networkx

RUN apt-get install -y --no-install-recommends libgflags-dev

WORKDIR /data

RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/Thrust.git

WORKDIR Thrust/thrust/system/cuda/detail

RUN rm -r cub-hip
RUN git clone --recursive https://github.com/ROCmSoftwarePlatform/cub-hip.git
WORKDIR cub-hip
RUN git checkout hip_port_1.7.4_caffe2
ENV THRUST_ROOT=/data/Thrust

WORKDIR $HOME

