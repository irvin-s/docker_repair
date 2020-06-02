FROM ubuntu:14.04 

FROM adreeve/python-numpy:latest 

RUN apt-get update \
    && apt-get --yes install git \
    wget \
    nano \
    python-software-properties\
    build-essential \
    python3-software-properties \
    software-properties-common

RUN mkdir -p /usr/bin
WORKDIR /usr/bin

RUN wget https://github.com/rioualen/gene-regulation/archive/4.0.tar.gz
RUN tar zvxf 4.0.tar.gz
WORKDIR gene-regulation-4.0

RUN make -f scripts/makefiles/install_tools_and_libs.mk all

RUN pip3 install -U pandas

RUN echo export SHELL=/bin/bash >> /root/.bashrc
RUN echo export PATH=$PATH:/root/bin >> /root/.bashrc


WORKDIR /usr/bin/gene-regulation-4.0

MAINTAINER Claire Rioualen <claire.rioualen@inserm.fr> 


