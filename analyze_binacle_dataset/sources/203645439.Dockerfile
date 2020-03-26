FROM python:3.5-alpine

RUN apk add --update jq

RUN pip install --upgrade pip
RUN pip install --upgrade awscli

ADD assets/ /opt/resource/
