FROM golang:1.6.1-alpine

RUN apk update && apk add docker

RUN go get github.com/ddollar/rerun

WORKDIR /go/src/github.com/convox/agent
COPY . /go/src/github.com/convox/agent
RUN go install ./...

ENV DOCKER_HOST unix:///var/run/docker.sock

ENTRYPOINT ["agent"]
