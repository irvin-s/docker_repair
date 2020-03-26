FROM ubuntu:16.04

MAINTAINER sangjing@leinao.ai
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    apt install -y openssh-client openssh-server && \
    apt clean
