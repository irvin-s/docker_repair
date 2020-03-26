FROM ubuntu:14.04
#QIIME basic installation env v0.1 
MAINTAINER Chester Kuo <chester.kuo@gmail.com>

RUN apt-get update && apt-get -y install curl
RUN apt-get -y --no-install-recommends install cmake mercurial git make subversion
RUN apt-get -y install gcc g++ gdb
RUN apt-get -y install python python-dev python-pip vim
RUN apt-get -y install pkg-config libpng-dev libfreetype6-dev
RUN apt-get -y install libopenblas-base libopenblas-dev libatlas-base-dev gfortran libblas-dev liblapack-dev mklibs


RUN mkdir -p /tmp

RUN pip install numpy
RUN pip install qiime

RUN print_qiime_config.py -t
