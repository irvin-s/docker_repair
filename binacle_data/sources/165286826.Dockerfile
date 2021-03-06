FROM ubuntu:xenial
MAINTAINER OpenStack <openstack-dev@lists.openstack.org>

RUN apt-get update --fix-missing
RUN apt-get install -y build-essential wget git python python-dev

RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py && rm get-pip.py
RUN pip install -U setuptools
