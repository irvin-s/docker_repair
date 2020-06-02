FROM fellah/ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

USER root

RUN apt-get -y update &&\
	apt-get -y install python2.7 python-pip bash-completion &&\
	pip install --upgrade awscli

RUN install --directory /etc/bash_completion.d &&\
	cp /usr/local/bin/aws_bash_completer /etc/bash_completion.d

USER fellah

WORKDIR /home/fellah
