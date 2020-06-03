FROM debian:jessie

WORKDIR /build
COPY requirements.txt /build/requirements.txt
COPY requirements-dev.txt /build/requirements-dev.txt

RUN apt-get update; \
    #apt-get install -y python-setuptools python-numpy python-dev libgdal-dev python-gdal gdal-bin swig git g++; \
    apt-get install -y python-dev python-setuptools libgdal-dev gdal-bin swig git g++; \
    easy_install pip; \
    pip install numpy==1.9.1;

RUN \
    pip install -r requirements.txt; \
    pip install -r requirements-dev.txt;

