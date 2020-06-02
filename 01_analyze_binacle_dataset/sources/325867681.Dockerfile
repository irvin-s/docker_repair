FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER ngchc (changc@mail.ustc.edu.cn)

# BUILD: docker build -t ngchc/auto-emseg:v0.1 .
# SETUP: nvidia-docker run -it -u 1000:1000 --name auto-seg-v0.1 --rm \
#        -v /home/changc/disk/emseg/projects/auto-emseg:/home/changc/auto-emseg \
#        ngchc/auto-emseg:v0.1 /bin/bash

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    # Handle the cache issue (comment it for speed)
    # sed -i 's/http:\/\/lt\./http:\/\//g' /etc/apt/sources.list && \
    apt-get -y update && \
    apt-get -y install build-essential autotools-dev rsync curl wget jq \
      openssh-server openssh-client sudo vim nano git \
	  xvfb openjdk-8-jdk software-properties-common && \
    add-apt-repository -y ppa:fkrull/deadsnakes && \
    apt-get -y install python2.7 python-pip libboost-dev && \
    apt-get autoremove && \
    apt-get autoclean && \
	apt-get clean

# Add a user
RUN useradd -m changc -u 1000 -s /bin/bash && \
    echo "changc:admin!" | chpasswd && \
    echo "changc ALL=(ALL) ALL" >> /etc/sudoers

# Anaconda3-5.2.0 Python3.6.5
USER changc
RUN wget --quiet https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O /home/changc/anaconda.sh && \
    /bin/bash /home/changc/anaconda.sh -b -p /home/changc/anaconda3 && \
    rm /home/changc/anaconda.sh

# Update environment variables
ENV PATH=/home/changc/anaconda3/bin:$PATH \
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
    STAGE_DIR=/home/changc \
    CUDNN_DIR=/usr/lib/x86_64-linux-gnu \
    CUDA_DIR=/usr/local/cuda-9.0

# Install packages for python
RUN mkdir /home/changc/.pip && \
    echo "[global]" > /home/changc/.pip/pip.conf && \
    sed -i -e "\$aindex-url=https://mirrors.ustc.edu.cn/pypi/web/simple" /home/changc/.pip/pip.conf && \
    pip install --upgrade pip && \
    pip install https://download.pytorch.org/whl/cu90/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl && \
    pip install torchvision && \
    conda config --add channels https://mirrors.ustc.edu.cn/anaconda/pkgs/free && \
    conda config --set show_channel_urls yes && \
    conda install opencv && \
    pip install SimpleITK tqdm libtiff joblib && \
    pip install --upgrade cython && \
    echo "admin!" | sudo -S pip2 install cython h5py numpy scipy munkres mahotas tqdm Pillow

WORKDIR $STAGE_DIR
