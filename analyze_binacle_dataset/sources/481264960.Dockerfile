#MUST BE BUILT FROM SERVICES DIRECTORY USING Firmament to take care of dependecies!!!! with -f flag
#  e.g.:  cd watchman/services
#         docker build -f Dockerfile-caffe-cudnn5 -t sotera/watchman-caffe-cudnn5:1.0 .
#         #  NOTE: tag "sotera/watchman-caffe-cudnn5:1.0" must match tag reference deploy-cudnn5.json
#         firmament m b -i deploy-cudnn5.json
#
#MUST BE BUILT on a system having NVidia driver support:
#
#   See configure_gpu.sh for more details and:
#   https://github.com/NVIDIA/nvidia-docker/wiki/Deploy-on-Amazon-EC2
#   https://developer.nvidia.com/cuda-downloads

FROM sotera/ubuntu-cudnn5:1.0

USER root

ENV TERM xterm

# Install git, bc and dependencies
RUN apt-get update --fix-missing && apt-get install -y \
  wget \
  bzip2 \
  ca-certificates \
  sudo \
  git \
  bc \
  vim \
  procps \
  curl \
  libglib2.0-0 \
  libxext6 \
  libsm6 \
  libxrender1 \
  libatlas-base-dev \
  libatlas-dev \
  libboost-all-dev \
  libopencv-dev \
  libprotobuf-dev \
  libgoogle-glog-dev \
  libgflags-dev \
  protobuf-compiler \
  libhdf5-dev \
  libleveldb-dev \
  liblmdb-dev \
  libsnappy-dev \
  htop

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
  wget --quiet --no-check-certificate https://repo.continuum.io/archive/Anaconda2-2.4.1-Linux-x86_64.sh && \
  /bin/bash Anaconda2-2.4.1-Linux-x86_64.sh -b -p /opt/conda && \
  rm Anaconda2-2.4.1-Linux-x86_64.sh

ENV PATH /opt/conda/bin:$PATH
ENV PYTHONPATH /home/caffe-user/caffe/python:$PYTHONPATH

RUN conda install -c https://conda.anaconda.org/memex elasticsearch-py && \
  conda install -c https://conda.anaconda.org/anaconda protobuf

RUN useradd -ms /bin/bash caffe-user && echo "caffe-user:caffe-user" | chpasswd && adduser caffe-user sudo
RUN chown -R caffe-user:caffe-user /usr/local

# Clone Caffe repo and move into it
RUN cd /home/caffe-user && git clone https://github.com/BVLC/caffe.git && cd caffe
# just pull a preconfigured Makefile.config from our repo...cheating a little here
RUN cd /home/caffe-user/caffe && wget --quiet https://raw.githubusercontent.com/Sotera/watchman/cudnn5/firmament/caffe/Makefile.config
# Make
RUN cd /home/caffe-user/caffe && make all

# Make Python Wrapper
RUN cd /home/caffe-user/caffe && \
  make pycaffe && \
  make distribute

RUN cd /home/caffe-user/caffe/models/bvlc_reference_caffenet && \
  wget --quiet http://dl.caffe.berkeleyvision.org/bvlc_reference_caffenet.caffemodel

RUN mkdir /home/caffe-user/src
RUN mkdir /home/caffe-user/src/util
RUN mkdir /home/caffe-user/src/service
WORKDIR /home/caffe-user/src/service

COPY ./caffe-image-featurizer/*.py ./

# match project dir structure to satisfy imports
COPY ./util/ ../util/

RUN chown -R caffe-user:caffe-user /home/caffe-user

USER caffe-user

ENV CAFFE_ROOT /home/caffe-user/caffe

CMD ["python", "-u", "main.py"]
