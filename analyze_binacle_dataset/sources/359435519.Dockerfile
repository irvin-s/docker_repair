FROM ubuntu:14.04
MAINTAINER kChen "kchen.ntu@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl wget software-properties-common

# Install torch7
WORKDIR /root
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
WORKDIR /root/torch
RUN /root/torch/install.sh


# Install loadcaffe
RUN apt-get install -y libprotobuf-dev protobuf-compiler
RUN /root/torch/install/bin/luarocks install loadcaffe

# Install neural-style
WORKDIR /root
RUN git clone --depth 1 https://github.com/jcjohnson/neural-style.git

WORKDIR /root/neural-style
RUN bash models/download_models.sh

