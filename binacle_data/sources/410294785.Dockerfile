# -*- conf -*-

FROM ubuntu:12.04
#tag 1.3.1

MAINTAINER Maciej Pasternacki <maciej@3ofcoins.net>

RUN apt-get update --yes
RUN apt-get install --yes openssl zlib1g libsqlite3-0 bzip2 ca-certificates

ADD https://downloads.egenix.com/python/egenix-pyrun-1.3.1-py2.7_ucs2-linux-x86_64.tgz /opt/pyrun/
ADD https://pypi.python.org/packages/source/s/setuptools/setuptools-4.0.1.tar.gz /tmp/
ADD https://pypi.python.org/packages/source/p/pip/pip-1.5.6.tar.gz /tmp/

RUN cd /opt/pyrun && tar -xzvf egenix-pyrun-*.tgz && rm egenix-pyrun-*.tgz
RUN cd /tmp && tar -xzvf setuptools-*.tar.gz && rm setuptools-*.tar.gz && cd setuptools-* && /opt/pyrun/bin/python setup.py install
RUN cd /tmp && tar -xzvf pip-*.tar.gz && rm pip-*.tar.gz && cd pip-* && /opt/pyrun/bin/python setup.py install
RUN rm -rf /tmp/setuptools-* /tmp/pip-*
RUN ln -sfv /opt/pyrun/bin/* /usr/local/bin/

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*
