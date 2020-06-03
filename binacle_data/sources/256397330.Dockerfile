###########################################
# Dockerfile for a webapp with prometheus
# logging enabled
# Based on python2
###########################################

FROM python:2.7

MAINTAINER Austin Ouyang

RUN pip install flask tornado requests prometheus_client

ENV APPDIR=/root/webapp

COPY . $APPDIR

WORKDIR $APPDIR

CMD [ "python", "-u", "tornadoapp.py" ]

