FROM golang:alpine AS builder  
  
ARG CONFD_VERSION=v0.15.0  
ARG CONFD_PKG=github.com/kelseyhightower/confd  
ARG CONFD_REPO=https://$CONFD_PKG.git  
ARG CONFD_SRC=$GOPATH/src/$CONFD_PKG  
  
RUN apk add \--no-cache --virtual .build-deps git  
  
RUN git clone --branch $CONFD_VERSION $CONFD_REPO $CONFD_SRC  
  
ENV CGO_ENABLED=0  
  
RUN export GIT_SHA=$(git -C $CONFD_SRC rev-parse --short HEAD || echo) && \  
go install -ldflags "-X main.GitSHA=${GIT_SHA}" $CONFD_PKG  
FROM alpine:latest  
LABEL maintainer="dochang@gmail.com"  
  
COPY \--from=builder /go/bin/confd /usr/local/bin/  

