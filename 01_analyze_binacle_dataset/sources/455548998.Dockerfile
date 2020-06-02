FROM ubuntu:xenial

RUN apt-get update -y
RUN apt-get install -y curl tar vim net-tools tcpdump

COPY conf/proxy.key.pem /opt/layer7proxy/proxy.key.pem
COPY conf/proxy.crt.pem /opt/layer7proxy/proxy.crt.pem

COPY layer7proxy /usr/local/bin/layer7proxy

WORKDIR /opt/layer7proxy
