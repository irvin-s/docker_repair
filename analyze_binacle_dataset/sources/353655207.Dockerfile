# clusterhq-flocker-cli Dockerfile
FROM ubuntu:14.04
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>

env CONTROL_HOSTNAME=ec2-52-27-159-173.us-west-2.compute.amazonaws.com

RUN sudo apt-get update
RUN sudo apt-get -y install apt-transport-https software-properties-common
RUN sudo add-apt-repository -y ppa:james-page/docker
RUN sudo add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"
RUN sudo apt-get update
RUN sudo apt-get -y --force-yes install clusterhq-flocker-cli
RUN sudo apt-get -y --force-yes install clusterhq-flocker-node

WORKDIR /flockercerts
RUN sudo bash -c "flocker-ca initialize mycluster; \
    flocker-ca create-control-certificate $CONTROL_HOSTNAME ; \
    flocker-ca create-node-certificate; \
    flocker-ca create-api-certificate myechuri;"
