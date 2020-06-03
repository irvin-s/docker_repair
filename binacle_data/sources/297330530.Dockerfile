FROM python:3-alpine
MAINTAINER Antonis Kalipetis <akalipetis@gmail.com>

RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

WORKDIR /usr/src/app
RUN pip install flask

COPY v2.py /usr/src/app/app.py
