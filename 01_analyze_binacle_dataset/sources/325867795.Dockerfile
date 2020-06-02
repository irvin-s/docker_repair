# base-image
FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Hantao Zhang <zht1994@mail.ustc.edu.cn>

# install dependency packages
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
        /etc/apt/sources.list.d/cuda.list \
        /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        autossh \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        git \
        graphviz \
        htop \
        libmysqlclient-dev \
        liblapack-dev \
        libopenblas-dev \
        libopencv-dev \
        locales \
        openssh-client \
        openssh-server \
        python-dev \
		python-numpy \
		python-pip \
		python-setuptools \
		python-scipy \
        tmux \
        unzip \
        vim \
        wget \
        zip

# install python 2.7
COPY ./requirements.txt requirements.txt

RUN mkdir ~/.pip && echo "[global]" > ~/.pip/pip.conf && \
	echo "index-url=https://pypi.mirrors.ustc.edu.cn/simple" >> ~/.pip/pip.conf && \
	echo "format = columns" >> ~/.pip/pip.conf && \
    pip install --upgrade pip && \
    sed -i 's/from pip import main/from pip._internal import main/g' /usr/bin/pip && \
    pip install -r requirements.txt && \
    pip install \
        Cython \
        && \
    pip install \
        h5py \
        matplotlib \
        numpy \    
        pandas \
        pycocotools \
        scikit-image \
        scikit-learn \
        scipy

# build mxnet from source
COPY ./mxnet mxnet

RUN cd mxnet && make -j 32 USE_OPENCV=1 USE_BLAS=openblas USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda USE_CUDNN=1
#RUN cd /root && git clone --recursive https://github.com/dmlc/mxnet.git && \
#    cd mxnet && \
#    git checkout 998378a && \
#    git submodule init && \
#    git submodule update && \
#    make -j 32 USE_OPENCV=1 USE_BLAS=openblas USE_CUDA=1 USE_CUDA_PATH=/usr/local/cuda USE_CUDNN=1 

RUN cd /mxnet/python && python setup.py install

RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python-tk \ 
        && \
    pip install pyyaml

# clean-up
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove
    #rm -rf /var/lib/apt/lists/* /tmp/* ~/*
