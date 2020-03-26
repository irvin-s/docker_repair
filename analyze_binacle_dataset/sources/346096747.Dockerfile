FROM ubuntu:trusty

RUN apt-get update && apt-get -y install dpkg-dev python-tox python-setuptools \
  python-dev debhelper python-yaml libyaml-dev git wget

RUN cd `mktemp -d` && wget http://mirrors.kernel.org/ubuntu/pool/universe/d/dh-virtualenv/dh-virtualenv_0.11-1_all.deb && dpkg -i dh-virtualenv_0.11-1_all.deb && apt-get -f install

ENV HOME /work
ENV PWD /work
WORKDIR /work