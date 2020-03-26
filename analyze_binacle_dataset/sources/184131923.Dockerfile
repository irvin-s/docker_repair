FROM python:3.7.0-alpine
COPY . /opt/tenyks-contrib
WORKDIR /opt/tenyks-contrib
RUN apk add --no-cache zeromq-dev gcc py3-zmq build-base libtool pkgconfig autoconf automake ca-certificates
RUN python setup.py install
