FROM golang:1.8.0-alpine

RUN apk add git --update

WORKDIR /go/src/lotery
COPY main.go main.go

RUN go get -d
RUN go install

ENTRYPOINT ["lotery"]