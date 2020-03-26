# Base GO image to build Caliopen GO applications
# Author: Caliopen
# Date: 2018-07-20

FROM golang:1.10.3
MAINTAINER Caliopen

RUN go get -u github.com/kardianos/govendor
RUN go install github.com/kardianos/govendor

COPY ./vendor /go/src/github.com/CaliOpen/Caliopen/src/backend/vendor
WORKDIR /go/src/github.com/CaliOpen/Caliopen/src/backend

# Fetch dependencies needed for Caliopen GO apps
RUN govendor sync -v
