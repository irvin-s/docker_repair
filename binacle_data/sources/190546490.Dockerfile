FROM ubuntu:14.04

# also, depends on https://github.com/graphite-project/carbon/pull/486
# once 0.9.16 is released, no need for special carbon install belos
ENV GRAPHITE_VERSION 0.9.15

RUN apt-get update && \
    apt-get -y install python-dev python-pip


RUN pip install whisper==$GRAPHITE_VERSION && \
    pip install https://github.com/Banno/carbon/tarball/0.9.x-fix-events-callback && \
    pip install graphite-web==$GRAPHITE_VERSION
