FROM ubuntu:14.04.4

RUN apt-get update -q -y && \
    apt-get upgrade -q -y

RUN apt-get install -q -y python python-dev libssl-dev libffi-dev && \
    apt-get install -q -y wget && \
    wget "https://bootstrap.pypa.io/get-pip.py" -O /dev/stdout | python

RUN pip install twisted petlib redis msgpack-python

RUN mkdir /app

WORKDIR /app
ADD core.py core.py
ADD checker.py checker.py

EXPOSE 9090 9191