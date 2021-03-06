#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#
FROM ubuntu:16.04

RUN apt-get update -qq
RUN apt-get install -qqy automake
RUN apt-get install -qqy libcurl4-openssl-dev
RUN apt-get install -qqy git
RUN apt-get install -qqy make
RUN apt-get install -qqy build-essential

RUN git clone https://github.com/BitzenyCoreDevelopers/cpuminer.git

RUN cd cpuminer && ./autogen.sh
RUN cd cpuminer && ./configure CFLAGS="-O3"
RUN cd cpuminer && make

WORKDIR /cpuminer
ENTRYPOINT ["./minerd"]
