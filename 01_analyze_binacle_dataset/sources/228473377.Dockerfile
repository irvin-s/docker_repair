# Version 1.0.4
FROM ubuntu:14.04

MAINTAINER Enrique Otero "enrique.otero@beeva.com"
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update
RUN sudo apt-get -y install \
	git \
	build-essential \
	cmake \
	wget \
	curl \
	libatlas-base-dev \
	gfortran

RUN curl -sk https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
RUN cd ~/torch; ./install.sh
RUN /bin/bash -c "source ~/.bashrc"

ENV PATH="$PATH:/root/torch/install/bin"

RUN luarocks install nn
RUN luarocks install nngraph
RUN luarocks install image

# Only for training
RUN apt-get -y install libprotobuf-dev protobuf-compiler
RUN luarocks install loadcaffe

RUN apt-get -y install libhdf5-dev hdf5-tools python-dev python-pip
RUN pip install cython numpy h5py scipy
RUN luarocks install hdf5

WORKDIR /home
RUN git clone https://github.com/karpathy/neuraltalk2
WORKDIR /home/neuraltalk2

RUN wget http://cs.stanford.edu/people/karpathy/neuraltalk2/checkpoint_v1_cpu.zip
RUN unzip checkpoint_v1_cpu.zip
