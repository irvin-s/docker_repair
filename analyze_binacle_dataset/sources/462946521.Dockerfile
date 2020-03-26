FROM docker:latest

RUN apk update && apk upgrade
RUN apk update && apk add python python-dev py-pip build-base
RUN pip install docker-compose pylama
