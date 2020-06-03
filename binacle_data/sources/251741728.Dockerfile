FROM nvidia/cuda:9.1-cudnn7-devel

RUN apt-get update && apt-get install -y --no-install-recommends \
  python3.5 \
  python3.5-dev \
  python3-pip \
  build-essential \
  cmake \
  git \
  curl \
  vim \
  ca-certificates \
  libjpeg-dev \
  libpng-dev &&\
  rm -rf /var/lib/apt/lists/*

RUN pip3 install numpy && \
  pip3 install wheel && \
  pip3 install setuptools && \
  pip3 install ninja && \
  pip3 install http://download.pytorch.org/whl/cu91/torch-0.4.0-cp35-cp35m-linux_x86_64.whl && \
  pip3 install torchvision

# Workaround for pip installation and pytorch test bugs.
RUN ln -s /usr/bin/python3 /usr/bin/python

WORKDIR /root
