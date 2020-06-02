FROM ubuntu:12.10
MAINTAINER Antonin Hildebrand <antonin@binaryage.com>

RUN apt-get update
RUN apt-get install -y python-leveldb python-setuptools python-pip python-openssl git
RUN pip install jsonrpclib

ADD	. /electrum
WORKDIR /electrum

RUN git clone https://github.com/spesmilo/electrum-server.git
WORKDIR /electrum/electrum-server
RUN chmod +x server.py

RUN ln -s /electrum/electrum-server/server.py /bin/electrum-server
RUN chmod +x /bin/electrum-server

EXPOSE 50001
EXPOSE 8081
EXPOSE 50002
EXPOSE 8082

ADD enter /enter
RUN	chmod +x /enter
ENTRYPOINT ["/enter"]