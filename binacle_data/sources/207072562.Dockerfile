FROM unocha/alpine-base-s6:latest

MAINTAINER Serban Teodorescu, teodorescu.serban@gmail.com

RUN apk add --update --no-cache \
        python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    rm -rf /var/lib/apk/*
