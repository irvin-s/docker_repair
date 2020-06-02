FROM nvidia/cuda:9.0-devel-ubuntu16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
        autotools-dev \
        build-essential \
        python3-dev \
        clang \
        cmake \
        git \
        gfortran-multilib \
        libatlas-base-dev \
        liblapacke-dev \
        pkg-config \
        wget \
        curl \
        zlib1g-dev \
        ca-certificates \
        # For Kaldi
        python-dev \
        automake \
        libtool \
        autoconf \
        subversion

# Install bazel. We cannot use use the "stable" build installable via
# "apt-get" because it has too many backwards-incompatible changes
# that break tensorflow. Ugh!
# https://github.com/bazelbuild/continuous-integration/issues/128
# https://github.com/bazelbuild/bazel/issues/4252
RUN apt-get install -y --no-install-recommends openjdk-8-jdk bash-completion && \
    curl -fsSL https://github.com/bazelbuild/bazel/releases/download/0.7.0/bazel_0.7.0-linux-x86_64.deb -O && \
    dpkg -i bazel_0.7.0-linux-x86_64.deb && \
    rm bazel_0.7.0-linux-x86_64.deb

# We can't use the Ubuntu cudnn docker container because tensorflow is
# dumb and can't figure out CUDNN's install path that way (as far as I
# know).
RUN CUDNN_DOWNLOAD_SUM=1a3e076447d5b9860c73d9bebe7087ffcb7b0c8814fd1e506096435a2ad9ab0e && \
    curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v7.0.5/cudnn-9.0-linux-x64-v7.tgz -O && \
    echo "$CUDNN_DOWNLOAD_SUM  cudnn-9.0-linux-x64-v7.tgz" | sha256sum -c - && \
    tar --no-same-owner -xzf cudnn-9.0-linux-x64-v7.tgz -C /usr/local && \
    rm cudnn-9.0-linux-x64-v7.tgz && \
    ldconfig

# Tensorflow python dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-numpy python3-dev python3-pip python3-wheel python3-setuptools
