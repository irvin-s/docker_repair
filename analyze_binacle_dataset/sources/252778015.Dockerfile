FROM golang:alpine  
MAINTAINER Antoine POPINEAU <antoine.popineau@appscho.com>  
  
RUN apk update && apk add git  
  
WORKDIR /go/src/github.com/apognu/mesos-consul-registrator  
COPY . /go/src/github.com/apognu/mesos-consul-registrator  
RUN go get ./... && go install .  
  
ENTRYPOINT [ "/go/bin/mesos-consul-registrator" ]

