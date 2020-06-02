FROM jupyter/scipy-notebook
MAINTAINER mdagost@gmail.com

RUN pip install keras
RUN pip install git+git://github.com/Theano/Theano.git --upgrade --no-deps
RUN pip install h5py

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
USER jovyan