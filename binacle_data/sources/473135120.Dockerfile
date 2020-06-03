FROM centos:centos7
MAINTAINER diego.uribe.gamez@gmail.com

RUN yum -y update
RUN yum -y install wget
RUN yum -y install epel-release
RUN yum -y install gcc gcc-c++
RUN yum -y install make
RUN yum clean all

RUN mkdir node-latest
RUN cd node-latest && wget http://nodejs.org/dist/v6.9.2/node-v6.9.2.tar.gz
RUN cd node-latest && tar xvf node-v6.9.2.tar.gz && rm node-v6.9.2.tar.gz
RUN cd node-latest && cd * && ./configure
RUN cd node-latest && cd * && make
RUN cd node-latest && cd * && make install
RUN ln -s /usr/local/bin/node /usr/bin/node
RUN ln -s /usr/local/bin/npm /usr/bin/npm
RUN cd ../../ && rm node-latest/ -r -f

RUN npm install -g node-inspector supervisor forever

COPY package.json /opt/package.json
RUN cd /opt/ && npm install
RUN rm -f /opt/package.json
