FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    git \
    libpoppler-cpp-dev \
    pkg-config  \
    python2.7 \
    python-dev \
    python-pip \
    python-roman \
    poppler-utils \
    vim


WORKDIR /usr/local

RUN git clone https://github.com/idiap/asrt.git

ADD requirements.txt /usr/local/asrt

WORKDIR /usr/local/asrt
RUN pip install -r requirements.txt

WORKDIR /usr/local/asrt
ENV NLTK_DATA=/usr/local/asrt/nltk_data

RUN mkdir -p NLTK_DATA && \
    python -m nltk.downloader punkt -d $NLTK_DATA && \
    python -m nltk.downloader europarl_raw -d $NLTK_DATA

ENV LANG=1
ENV REGEX=examples/resources/regex.csv

ENTRYPOINT ["data-preparation/python/run_data_preparation.py", \
    "-l", "0", \
    "-r", "examples/resources/regex.csv", "-s", "-m"]

# requires -i inputfile -o outputfolder and mounting volume
