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
mkdir -p /root/.ssh && \
mkdir -p /home/build && \
mkdir -p /home/judger/bin/json

ADD .vimrc /root/.vimrc
ADD id_rsa /root/.ssh/id_rsa
ADD id_rsa.pub /root/.ssh/id_rsa.pub

ADD jsoncpp /home/build/jsoncpp
WORKDIR /home/build/jsoncpp
RUN chmod +x /home/build/jsoncpp/install.sh && \
/home/build/jsoncpp/install.sh

ADD bin /home/judger/bin

WORKDIR /home/judger
