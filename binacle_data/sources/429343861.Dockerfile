FROM alpine:3.7
MAINTAINER Claudio Sparpaglione <csparpa@gmail.com>

# Install apk packages
RUN apk add --update python python3 python-dev python3-dev py-pip 
RUN apk add --update wget gcc linux-headers musl-dev ca-certificates zlib && \
    apk add --update gobject-introspection py-gobject py-dbus 

# Mount latest source code
ADD . /pyowm
WORKDIR /pyowm
COPY tests/get_temperature.py /usr/bin

# 
RUN python setup.py install && \
    pip install ipython && \
    pip3 install ipython && \
    pip install -r /pyowm/dev-requirements.txt && \
    pip3 install -r /pyowm/dev-requirements.txt

# Deprecated: Install setuptools and setuptools3
#RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python && \
#    wget https://bootstrap.pypa.io/ez_setup.py -O - | python3

