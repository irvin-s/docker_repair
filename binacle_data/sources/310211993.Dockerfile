FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04
ENV LANG C.UTF-8

###########
## Tools ##
###########

RUN apt-get update --fix-missing && apt-get install -y \
    wget \
    vim \
    git \
    unzip \
    cmake \
    imagemagick

# downgrade to cudnn 7.0 (tensorflow 1.5 binary doesn't work with 7.1)
RUN apt-get update && apt-get install -y --allow-downgrades --no-install-recommends \
    bzip2 \
    g++ \
    git \
    graphviz \
    libgl1-mesa-glx \
    libhdf5-dev \
    openmpi-bin \
    wget \
    libcudnn7=7.0.5.15-1+cuda9.0 \
    libcudnn7-dev=7.0.5.15-1+cuda9.0 \
    && \
    rm -rf /var/lib/apt/lists/*

##############
## Anaconda ##
##############

RUN apt-get update --fix-missing && apt-get install -y \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

ENV PATH /opt/conda/bin:$PATH

#########################
## faceswap_live dependencies ##
#########################

#RUN git clone --recurse-submodules https://github.com/alew3/faceit_live.git /code/faceit_live


WORKDIR /code/faceit_live

# Solves: `libjpeg.so.8: cannot open shared object file: No such file or directory`
#          after `from PIL import Image`
RUN apt-get install -y libjpeg-turbo8

RUN echo export CUDA_DEVICE_ORDER="PCI_BUS_ID" >> ~/.bashrc

# https://software.intel.com/en-us/mkl
RUN /bin/bash -c "\
    conda install -y mkl-service && \
    conda install -y -c menpo ffmpeg"

RUN echo "export MKL_DYNAMIC=FALSE" >> ~/.bashrc

RUN python --version
RUN echo "installing python requirements"
COPY requirements.txt /code/

RUN /bin/bash -c "\
    pip install --upgrade pip && \
    pip install -r /code/requirements.txt"

# edit ImageMagick policy /etc/ImageMagick-6/policy.xml
# comment out this line <policy domain="path" rights="none" pattern="@*" />
RUN sed -i s:'<policy domain="path" rights="none" pattern="@\*" />':'<!-- & -->':g /etc/ImageMagick-6/policy.xml