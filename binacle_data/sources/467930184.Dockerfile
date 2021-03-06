FROM golang:1.11.2-stretch@sha256:498f71698c1bcbf50d6e5f08ce60c30ccab3ab5b6775c4b5395b1ae1a367bdab as go
ENV GOOS=linux GOARCH=amd64 CGO_ENABLED=1

ARG DISCOVERER_NAME
ARG DISCOVERER_PORT
ENV DISCOVERER_NAME=${DISCOVERER_NAME} DISCOVERER_PORT=${DISCOVERER_PORT} PORT=8080

WORKDIR $GOPATH/src/github.com/ockam/resolver/
COPY main.go $PWD
RUN go get
RUN go build main.go
ENTRYPOINT ["./main"]
