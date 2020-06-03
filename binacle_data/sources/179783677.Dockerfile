FROM fellah/ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

USER root

## install ansible
RUN apt-get --yes install software-properties-common && \
	apt-add-repository --yes ppa:ansible/ansible && \
	apt-get update && \
	apt-get --yes install ansible

RUN apt-get --yes install sshpass

USER fellah
