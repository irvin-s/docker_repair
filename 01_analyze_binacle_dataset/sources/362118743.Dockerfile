FROM golang:1.9.2
MAINTAINER peter.edge@gmail.com

RUN \
  curl -sSL https://download.docker.com/linux/static/stable/x86_64/docker-17.03.2-ce.tgz > docker.tgz && \
  tar xvzf docker.tgz && \
  cp docker/* /bin/ && \
  rm -rf docker docker.tgz
WORKDIR /go/src/go.pedge.io/openflights
ADD . /go/src/go.pedge.io/openflights/
