FROM ubuntu:14.04  
MAINTAINER Maarten De Paepe <maarten.de.paepe@adimian.com>  
  
RUN DEBIAN_FRONTEND=noninteractive \  
apt-get update -y && \  
apt-get install -yqq \  
python3 python3-dev libffi-dev mercurial  
  
ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py  
RUN python3 /tmp/get-pip.py  
  
ADD requirements.txt /tmp/requirements.txt  
RUN pip3 install -r /tmp/requirements.txt  
  
ADD . /source  
  
ENV AMMONITE_CONFIG=/etc/ammonite/config.cfg  
  
WORKDIR /source  
  
RUN echo docker:x:999:www-data >> /etc/group  
  
USER www-data  
CMD python3 /source/ammonite/worker.py

