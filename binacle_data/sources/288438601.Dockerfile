
FROM ubuntu:16.04

RUN apt-get update \
    && apt-get install -y build-essential python python-dev python-pip git \
    && pip install psutil
