FROM ubuntu:18.04

RUN apt-get update && apt-get install -qfy python-pip

WORKDIR /build_docker

COPY docker/dummydb/requirements.txt /build_docker/requirements.txt
RUN pip install -r requirements.txt --require-hashes

COPY mintools /build_docker/mintools
COPY explorer /build_docker/explorer
COPY setup.py /build_docker/setup.py
RUN python /build_docker/setup.py develop

COPY docker/dummydb/Procfile /build_docker/docker/dummydb/Procfile
COPY docker/dummydb/.env /build_docker/docker/dummydb/.env
CMD honcho start -e docker/dummydb/.env -f docker/dummydb/Procfile
