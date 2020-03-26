FROM ubuntu:latest
MAINTAINER Gianluca Arbezzano <gianarb92@gmail.com>

RUN apt-get update
RUN apt-get install -y wget build-essential libpcre3-dev libssl-dev
RUN wget http://www.haproxy.org/download/1.6/src/haproxy-1.6.0.tar.gz
RUN tar -xzvf haproxy-1.6.0.tar.gz
WORKDIR ./haproxy-1.6.0

RUN make TARGET=linux26 USE_PCRE=1 CPU=generic USE_OPENSSL=1 USE_LIBCRYPT=1
RUN make install-bin

CMD ["haproxy", "-v"]
