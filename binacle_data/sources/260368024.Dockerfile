FROM ubuntu:16.04

MAINTAINER Amir Barkal <amirb@webtech-inv.co.il>

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		netcat \
	&& rm -rf /var/lib/apt/lists/*

ARG user=was

ARG group=was

RUN groupadd $group && useradd $user -g $group -m \
    && mkdir /work && chown -R $user:$group /work

USER $user

ADD was.tar /

ENV PATH /opt/IBM/WebSphere/AppServer/bin:$PATH

RUN managesdk.sh -setCommandDefault -sdkname 1.7.1_64 \
    && managesdk.sh -setNewProfileDefault -sdkname 1.7.1_64
