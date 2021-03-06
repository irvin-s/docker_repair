# Set the base image to Ubuntu 16.04
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

ENV TERM=dumb

# Install Albacore and its dependencies
RUN apt update && \
    apt install --yes wget \
                      apt-transport-https && \
    wget -O- https://mirror.oxfordnanoportal.com/apt/ont-repo.pub | apt-key add - && \
    echo "deb http://mirror.oxfordnanoportal.com/apt trusty-stable non-free" > /etc/apt/sources.list.d/nanoporetech.sources.list && \
    apt update && \
    apt install --yes python3 \
                      python3-h5py \
                      python3-numpy \
                      python3-dateutil \
                      python3-pkg-resources \
                      libboost-program-options1.58.0 \
                      libboost-system1.58.0 \
                      libboost-python1.58.0 \
                      libboost-filesystem1.58.0 \
                      libboost-log1.58.0 \
                      libboost-thread1.58.0 \
                      python3-ont-fast5-api && \
    wget -q https://mirror.oxfordnanoportal.com/software/analysis/python3-ont-albacore_1.2.5-1%7Exenial_all.deb && \
    dpkg -i python3-ont-albacore_*.deb && \
    apt remove --purge --yes wget && \
    apt clean && \
    rm python3-ont-albacore_*.deb
