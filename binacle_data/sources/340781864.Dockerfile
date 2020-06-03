FROM google/golang

MAINTAINER Tyrell Keene <tyrell.wkeene@gmail.com>

RUN useradd -ms /bin/bash autobd
USER autobd

ENV GOPATH=/home/autobd/go

ADD ./autobd ./autobd

RUN mkdir /home/autobd/data
VOLUME /home/autobd/data

RUN mkdir /home/autobd/etc
VOLUME /home/autobd/etc

EXPOSE 8080
ENTRYPOINT ./autobd -config /home/autobd/etc/config.toml.node
