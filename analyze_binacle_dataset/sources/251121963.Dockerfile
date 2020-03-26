FROM golang:latest
ADD . /go/
ENV PROJECT_DIR /go/
WORKDIR ${PROJECT_DIR}
