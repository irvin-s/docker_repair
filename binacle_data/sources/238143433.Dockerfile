FROM ubuntu

MAINTAINER mhy12345 <maohanyang789@163.com>

RUN apt-get update

RUN apt-get install -y git && \
apt-get install -y vim && \
apt-get install -y g++ && \
apt-get install -y gdb && \
apt-get install -y python && \
apt-get install -y fpc 

RUN mkdir -p /home/judger && \
mkdir -p /root/.ssh  && \
mkdir -p /home/judger/tmp && \
mkdir -p /home/judger/run

ADD .vimrc /root/.vimrc

ADD bin /home/judger/bin

RUN apt-get install -y make
WORKDIR /home/judger/bin
RUN make

WORKDIR /home/judger
