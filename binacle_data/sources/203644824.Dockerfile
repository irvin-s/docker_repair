### Input arguments ###
ARG TORCH_CUDA_TAG=8.0-ubuntu16.04

### Start with CUDA Torch ###
FROM mauvilsa/torch-cuda:$TORCH_CUDA_TAG

MAINTAINER Mauricio Villegas <mauricio_ville@yahoo.com>

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["/bin/bash", "-c"]

### Copy source code ###
COPY . /tmp/Laia

### Install pre-requisites ###
RUN add-apt-repository -y ppa:george-edison55/cmake-3.x \
 && apt-get update --fix-missing \
 && apt-get purge -y cmake \
 && apt-get install -y --no-install-recommends \
      cmake \
      libgoogle-glog-dev \
      libgtest-dev \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \

### Install warp-ctc and imgdistort ###
 && luarocks install http://raw.githubusercontent.com/baidu-research/warp-ctc/master/torch_binding/rocks/warp-ctc-scm-1.rockspec \
 && git clone --depth 1 https://github.com/jpuigcerver/imgdistort.git /tmp/imgdistort \
 && cd /tmp/imgdistort \
 && luarocks make torch/imgdistort-scm-1.rockspec \

### Install Laia ###
 && LIBRARY_PATH=$(echo "$LIBRARY_PATH" | sed 's|^:||; s|:$||; s|::|:|g;') \
 && cd /tmp/Laia \
 && luarocks make rocks/laia-scm-1.rockspec \
 && mv dockerfiles/laia-docker /usr/local/bin \
 && luarocks install lalarm \

### Remove temporal files ###
 && cd \
 && rm -fr /tmp/* \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
