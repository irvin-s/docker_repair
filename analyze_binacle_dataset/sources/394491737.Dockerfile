############################################################
# Dockerfile to build Genropy container images
# Based on Ubuntu
############################################################

FROM genropy/ubuntu-python
MAINTAINER Francesco Porcari - francesco@genropy.org

ADD . /home/genropy
WORKDIR /home/genropy/gnrpy
RUN paver develop
RUN python initgenropy.py

RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf




