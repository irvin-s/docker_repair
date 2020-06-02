FROM ubuntu:16.04

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y openjdk-8-jdk zip unzip wget

RUN apt-get install -y make iputils-ping curl openssl apt-transport-https ca-certificates software-properties-common