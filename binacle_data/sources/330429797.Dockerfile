FROM nvidia/cuda:8.0-cudnn5-devel

MAINTAINER Adam Van Etten

# nvidia-docker build -t basiss /path_to_bassis/docker
# nvidia-docker run -it -v /raid:/raid --name bassiss_train basiss

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        git \
        libcurl3-dev \
        libfreetype6-dev \
        libpng12-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        rsync \
        software-properties-common \
        unzip \
        zip \
        zlib1g-dev \
        libopencv-dev \
        python-opencv \
        build-essential autoconf libtool libcunit1-dev \
        libproj-dev libgdal-dev libgeos-dev libjson0-dev vim python-gdal \
    	# requirements for keras
    	python-h5py \
    	python-yaml \
    	python-pydot \
	graphviz \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fSsL -O https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    rm get-pip.py


RUN pip --no-cache-dir install \
        ipykernel \
        jupyter \
        matplotlib \
        numpy \
        scipy \
        sklearn \
	pandas \
	h5py \
        && \
    python -m ipykernel.kernelspec


# Install TensorFlow GPU version.
#RUN pip --no-cache-dir install tensorflow-gpu

#RUN pip --no-cache-dir install \
#    http://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-0.0.0-cp27-none-linux_x86_64.whl

ARG TENSORFLOW_VERSION=1.2.1
ARG TENSORFLOW_DEVICE=gpu
ARG TENSORFLOW_APPEND=_gpu
RUN pip --no-cache-dir install https://storage.googleapis.com/tensorflow/linux/${TENSORFLOW_DEVICE}/tensorflow${TENSORFLOW_APPEND}-${TENSORFLOW_VERSION}-cp27-none-linux_x86_64.whl


# keras
#RUN pip --no-cache-dir install keras
#RUN git clone git://github.com/fchollet/keras.git /src 
#RUN pip --no-cache-dir install -e /src[tests] 
#RUN pip --no-cache-dir install git+git://github.com/fchollet/keras.git 

ARG KERAS_VERSION=2.0.6
ENV KERAS_BACKEND=tensorflow
RUN pip --no-cache-dir install --no-dependencies git+https://github.com/fchollet/keras.git@${KERAS_VERSION}


# Set up our notebook config.
WORKDIR /root

# TensorBoard
RUN ["/bin/bash"]
