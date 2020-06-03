FROM ubuntu:14.04

ADD . /
RUN ./install-prerequisites.sh

ENV PATH /dx-toolkit/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH /dx-toolkit/share/dnanexus/lib/python2.7/site-packages:/dx-toolkit/lib/python:
ENV CLASSPATH /dx-toolkit/lib/java/*:
ENV DNANEXUS_HOME /dx-toolkit

ENTRYPOINT ["python", "/dx-cwl"]
