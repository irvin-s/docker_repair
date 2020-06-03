FROM ubuntu:18.04

ENV APPDIR /app
WORKDIR $APPDIR
RUN mkdir -p $APPDIR/phpipam_pyclient
RUN mkdir -p $APPDIR/tests

RUN apt-get update && apt-get install python python-pip -y
RUN apt-get update && apt-get install python3 python3-pip -y

COPY requirements.txt $APPDIR/
COPY setup.py $APPDIR/
COPY tox.ini $APPDIR/
COPY phpipam_pyclient/config.json $APPDIR/

ADD phpipam_pyclient $APPDIR/phpipam_pyclient
ADD tests $APPDIR/tests

RUN pip3 install -r requirements.txt -U -e .
