FROM golang:1.11 AS builder

ADD https://github.com/golang/dep/releases/download/v0.5.0/dep-linux-amd64 /usr/bin/dep
RUN chmod +x /usr/bin/dep
WORKDIR /go/src/github.com/pearsontechnology/bitesize-controllers/vault-controller
COPY Gopkg.toml Gopkg.lock ./
RUN dep ensure --vendor-only
COPY . ./
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build controller.go

FROM 815492460363.dkr.ecr.us-east-1.amazonaws.com/bitesize/image-base:latest
COPY --from=builder /go/src/github.com/pearsontechnology/bitesize-controllers/vault-controller/controller .

LABEL maintainer "martin.devlin@pearson.com"

#RUN apk --update add bash

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
