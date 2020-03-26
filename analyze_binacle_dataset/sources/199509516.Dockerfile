# Base Python image to build Caliopen Python applications
# Author: Caliopen
# Date: 2018-07-20

FROM python:2-alpine
MAINTAINER Caliopen

# Install gcc openssl and ffi lib
RUN apk add --no-cache build-base openssl-dev libffi-dev

# Install cassandra-driver regex
RUN pip install --upgrade pip
RUN pip install cassandra-driver==3.4.1
RUN pip install regex

CMD ["python2"]
