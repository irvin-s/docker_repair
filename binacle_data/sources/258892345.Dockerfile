FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04

# To allow unicode characters in the terminal
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# To make the CUDA device order match the IDs in nvidia-smi
ENV CUDA_DEVICE_ORDER=PCI_BUS_ID

###########
## Tools ##
###########

RUN apt-get update --fix-missing && apt-get install -y \
    wget \
    vim \
    git \
    unzip

##############
## Anaconda ##
##############

# https://github.com/ContinuumIO/docker-images/blob/master/anaconda3/Dockerfile

RUN apt-get update --fix-missing && apt-get install -y bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh

# Removed Tini because Docker 1.13 has the --init flag.

ENV PATH /opt/conda/bin:$PATH

#############
## PyTorch ##
#############

# http://pytorch.org/previous-versions/

RUN conda install pytorch=0.2.0 torchvision cuda80 -c pytorch

################################
## efficient_densenet_pytorch ##
################################

RUN pip install \
    fire

RUN git clone https://github.com/gpleiss/efficient_densenet_pytorch.git

ENV DATA_DIR /data

WORKDIR efficient_densenet_pytorch

CMD bash
