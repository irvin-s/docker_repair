# Base image
FROM python:3.6
# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app

RUN pip3 install -r ./requirements.txt

RUN apt-get update && \
    apt-get install -y nodejs

WORKDIR /usr/src/app/src