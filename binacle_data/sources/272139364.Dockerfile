#  Dockerfile:  TF
#
#  Description:  TensorFlow w/goofys, no entrypoint
#
#  Version:   Tensorflow=1.0.1, python=2.7.13
#
#  Requirements:  None

FROM ubuntu:16.04

# Install basic packages to build the image
RUN apt-get update && \
    apt-get install -y \
    aptitude vim wget python time \
    software-properties-common \
    python-software-properties \
    gfortran liblapack-dev \
    pkg-config libpng-dev libfreetype6-dev \
    python-setuptools python-pip python-dev \
    libpq-dev git fuse

# Note: numpy is installed first -- this is intentional
RUN pip install numpy

RUN pip install scipy pandas sklearn matplotlib \
    psycopg2 sqlalchemy

ENV TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.0.1-cp27-none-linux_x86_64.whl

RUN pip install --upgrade $TF_BINARY_URL

RUN wget https://github.com/kahing/goofys/releases/download/v0.0.10/goofys && \
    chmod +x goofys && \
    mv goofys /usr/local/bin/

EXPOSE 5432 2222