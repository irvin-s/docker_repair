FROM ubuntu:16.04

USER root

RUN apt-get update && \
    apt-get install -y  --no-install-recommends \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libfontconfig1 \
        libxrender1 \
        python \
        python-pip && \
    rm -rf /var/lib/apt/lists/*

RUN pip install opencv-python

RUN useradd recognition

USER recognition

COPY python/server /python/server
COPY data/openface.nn4.small2.v1.t7 /data/openface.nn4.small2.v1.t7

EXPOSE 8080

CMD cd /python/server && ./server.py