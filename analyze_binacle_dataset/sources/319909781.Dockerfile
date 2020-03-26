FROM golang:1.10-stretch

RUN apt-get update && \
    apt-get install -y build-essential golang-glide && \
    apt-get clean

ENV GOPATH=/wc2018-slack-bot

WORKDIR /wc2018-slack-bot
