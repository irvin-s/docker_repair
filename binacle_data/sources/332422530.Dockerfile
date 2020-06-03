#FROM nvcr.io/nvidia/cuda:9.2-cudnn7-runtime-ubuntu16.04
#FROM ubuntu:16.04
#From  nvcr.io/nvidia/cuda:9.2-runtime-ubuntu16.04
From nvcr.io/nvidia/cuda:9.0-runtime-ubuntu16.04
# maintainer details
MAINTAINER deepbrainchain "dbc.ubuntu"
#ADD bminer-v10.2.0-c698b5f_  /bminer

RUN apt-get update
RUN apt  install  -y libcurl4-openssl-dev  && \
    apt  install  -y libgomp1 && \
    apt install -y curl && \
    apt install -y wget 

ADD miner /opt/
