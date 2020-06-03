###############################################################
# Dockerfile to build cannacoin-electrum server container images
# Based on Ubuntu
###############################################################

FROM ubuntu:14.04
MAINTAINER laudney

RUN apt-get update
RUN apt-get install -y git make g++ python-setuptools python-openssl python-leveldb python-dev libleveldb-dev wget
RUN apt-get clean
RUN easy_install jsonrpclib irc plyvel

RUN adduser cannacoin --disabled-password
USER cannacoin

WORKDIR /home/cannacoin
RUN mkdir bin src
RUN echo PATH=\"\$HOME/bin:\$PATH\" >> .bash_profile

WORKDIR /home/cannacoin/src
RUN git clone https://github.com/cannacoin-project/cannacoin-electrum-server.git

USER root
WORKDIR /home/cannacoin/src/cannacoin-electrum-server
RUN ./configure
RUN python setup.py install

WORKDIR /var
RUN touch /var/log/electrum.log
RUN chown cannacoin:cannacoin /var/log/electrum.log
RUN wget -q http://cannacoin.cc/electrum.tar.gz
RUN tar -zxvf electrum.tar.gz
RUN rm electrum.tar.gz
RUN chown cannacoin:cannacoin -R electrum-server

RUN echo "cannacoin hard nofile 65536" >> /etc/security/limits.conf
RUN echo "cannacoin soft nofile 65536" >> /etc/security/limits.conf

USER cannacoin
WORKDIR	/home/cannacoin
RUN openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
RUN openssl rsa -passin pass:x -in server.pass.key -out server.key
RUN rm server.pass.key
RUN openssl req -new -key server.key -out server.csr -subj '/CN=www.my.com/O=My Company Name LTD./C=US'
RUN openssl x509 -req -days 730 -in server.csr -signkey server.key -out server.crt

ENV HOME /root
EXPOSE 50001 50002
USER root
