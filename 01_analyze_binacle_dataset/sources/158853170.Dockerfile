# Kubernetes: build
#

FROM ubuntu:latest
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

RUN apt-get update -y && apt-get install --no-install-recommends -y -q golang git
RUN mkdir /opt/gopath
ENV GOPATH /opt/gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

RUN mkdir -p /kubernetes-binaries/
RUN mkdir -p $GOPATH/src/github.com/GoogleCloudPlatform
WORKDIR /opt/gopath/src/
RUN git clone https://github.com/GoogleCloudPlatform/kubernetes.git github.com/GoogleCloudPlatform/kubernetes

RUN mkdir -pv /opt/gopath/src/golang.org/x/tools
#RUN go get github.com/tools/godep
RUN git clone https://github.com/golang/tools.git
ADD tools /opt/gopath/src/golang.org/x/tools
RUN go install golang.org/x/tools/cmd/cover

WORKDIR /opt/gopath/src/github.com/GoogleCloudPlatform/kubernetes
RUN pwd
RUN bash -x ./hack/build-go.sh
RUN mv _output/go/bin/* /kubernetes-binaries/
VOLUME /kubernetes-binaries
