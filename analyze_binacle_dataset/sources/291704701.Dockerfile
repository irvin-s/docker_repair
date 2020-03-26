FROM golang:1.10.3-alpine3.8
MAINTAINER Monax <support@monax.io>

# This is the image used by the Circle CI config in this directory pushed to quay.io/monax/bosmarmot:ci
# docker build -t quay.io/monax/build:bosmarmot-ci -f ./.circleci/Dockerfile .
RUN apk add --update --no-cache nodejs npm netcat-openbsd git make bash gcc g++ jq parallel python
RUN echo -ne "will cite" | parallel --citation || true
RUN go get github.com/jstemmer/go-junit-report
RUN go get -u github.com/golang/dep/cmd/dep
RUN npm install -g mocha
RUN npm install -g standard
RUN npm install -g mocha-circleci-reporter
