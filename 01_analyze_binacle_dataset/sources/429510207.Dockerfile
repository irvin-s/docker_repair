FROM python:3.5-slim

RUN apt-get update && \
    apt-get install -y python2.7 && \
    apt-get install -y build-essential && \
    apt-get install -y apache2
RUN pip install tox

COPY src/sdk2/bonsai-ai /brain/src/sdk2/bonsai-ai

WORKDIR /brain/src/sdk2/bonsai-ai
RUN tox --notest
