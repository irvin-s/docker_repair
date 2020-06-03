FROM ubuntu:14.04
MAINTAINER tonyo

RUN useradd -m box

COPY bootstrap.sh /bootstrap.sh
RUN /bin/bash bootstrap.sh && /bin/rm bootstrap.sh


CMD cd /home/box && echo 123 && su box
