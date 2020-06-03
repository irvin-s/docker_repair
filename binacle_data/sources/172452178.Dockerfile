FROM ubuntu

RUN apt-get update
RUN apt-get install -yy iproute2 software-properties-common netcat net-tools iputils-ping
RUN add-apt-repository -u -y ppa:wireguard/wireguard
RUN apt-get -yy install wireguard-tools

RUN mkdir /demo
COPY *.wgconf /demo/
