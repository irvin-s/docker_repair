FROM ubuntu:16.04
MAINTAINER Emilio Coppa <ercoppa@gmail.com>

RUN apt-get update && apt-get install -y sudo nano git build-essential automake && rm -rf /var/lib/apt/lists/*

RUN useradd -m ubuntu && \
    echo ubuntu:ubuntu | chpasswd && \
    cp /etc/sudoers /etc/sudoers.bak && \
    echo 'ubuntu  ALL=(root) NOPASSWD: ALL' >> /etc/sudoers
USER ubuntu
WORKDIR /home/ubuntu

RUN git clone https://github.com/ercoppa/aprof
RUN cd aprof/valgrind/ && ./build.sh
