FROM ubuntu:14.04
# FROM nvidia/cuda:7.5-cudnn5-devel

MAINTAINER Kevin Mader <kmader@4quant.com>

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libhdf5-dev g++ graphviz libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN mkdir -p $CONDA_DIR && \
    echo export PATH=$CONDA_DIR/bin:'$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -f -b -p $CONDA_DIR && \
    rm ~/anaconda.sh

# Needed for OpenCV
RUN apt-get install -y libgtk2.0-0

RUN useradd -m deepinfer && echo "deepinfer:deepinfer" | chpasswd && adduser deepinfer sudo

RUN mkdir -p $CONDA_DIR && \
    chown deepinfer $CONDA_DIR -R

USER deepinfer

# Python
RUN pip install --upgrade pip && \
    pip install theano && \
    pip install progressbar2 && \
    pip install SimpleITK && \
    pip install ipdb pytest pytest-cov python-coveralls coverage==3.7.1 pytest-xdist pep8 pytest-pep8 pydot_ng && \
    pip install git+git://github.com/fchollet/keras.git && \
    conda install -c menpo opencv=2.4.11 && \
    conda clean -yt

RUN mkdir /home/deepinfer/.keras && \
    mkdir /home/deepinfer/.keras/models && \
    echo { '"image_dim_ordering"': '"th"', '"epsilon"': 1e-07, '"floatx"': '"float32"', '"backend"': '"theano"'}>/home/deepinfer/.keras/keras.json


RUN mkdir -p /home/deepinfer/github && \
    mkdir -p /home/deepinfer/github/bone-segmenter && \
    mkdir /home/deepinfer/data

WORKDIR "/home/deepinfer/github/bone-segmenter"

ADD boneseg /home/deepinfer/github/bone-segmenter/boneseg
ADD fit.py /home/deepinfer/github/bone-segmenter/
ADD cnn_weights.h5 /home/deepinfer/.keras/models/unet1_weights.h5

WORKDIR "/home/deepinfer"

ENTRYPOINT ["python","/home/deepinfer/github/bone-segmenter/fit.py"]
