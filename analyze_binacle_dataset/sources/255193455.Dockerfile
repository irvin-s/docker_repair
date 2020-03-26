FROM nvidia/cuda:8.0-cudnn5-devel-centos7
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum update -y && yum install -y epel-release && \
    yum -y group install "Development Tools" && yum install -y \
    cmake \
    git \
    wget \
    openblas-devel \
    python-devel \
    python-pip \
    numpy \
    scipy \
    vim

RUN pip install --upgrade pip \
    nose \
    nose_parameterized \
    pydicom

# Install bleeding-edge Theano
ENV CLONE_TAG=master
RUN pip install --upgrade --no-deps git+http://github.com/Theano/Theano.git@$CLONE_TAG
# Set up .theanorc for CUDA
RUN printf "[global]\ndevice=gpu\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True" > /root/.theanorc

WORKDIR /root/
COPY src/check1.py .
