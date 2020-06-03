FROM python:2-alpine

ENV MESOS_VERSION=1.0.1 

RUN cd /tmp && wget -O - /tmp https://github.com/kszucs/mesos-alpine/archive/master.zip | gunzip \
    && pip install google-commons 'protobuf<3' \
    && pip install --use-wheel --no-index --find-links=/tmp mesos \
    && rm -rf /tmp/*
    
    