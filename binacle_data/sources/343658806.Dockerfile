FROM ubuntu:14.04

MAINTAINER Balram Ramanathan <balram.ramanathan@sirca.org.au>

RUN apt-get update
RUN apt-get install -y gcc python2.7 python2.7-dev python-pip python-pandas

RUN pip install ipython[all] scipy
