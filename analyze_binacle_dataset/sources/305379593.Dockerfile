FROM ubuntu:trusty
MAINTAINER Alex Stapleton <alexs@prol.etari.at>

RUN apt-get update
RUN apt-get install -y python-pip
RUN pip install -U pip
RUN pip install wheel

ADD packages.txt /tmp/
RUN xargs apt-get install -y < /tmp/packages.txt && rm /tmp/packages.txt

ADD bin/ /root/bin/
