# dataset-agent Dockerfile
FROM clusterhq/flocker-core:1.8.0
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>

RUN sudo apt-get install -y python-pip build-essential libssl-dev libffi-dev python-dev
RUN sudo pip install git+https://github.com/clusterhq/unofficial-flocker-tools.git
RUN sudo pip install eliot-tree

# Tox - for unit testing storage driver
RUN sudo pip install tox