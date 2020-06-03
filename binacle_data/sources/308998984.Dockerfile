# BUILDER
FROM golang:1.10 AS builder
ARG SERVICE=handler
COPY . /go/src/github.com/lawrencegripper/ion
WORKDIR /go/src/github.com/lawrencegripper/ion/cmd/$SERVICE
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo

# RUNNER
FROM alpine:3.7
ARG SERVICE=handler
RUN apk --no-cache --update add \
    ca-certificates
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/$SERVICE .

# it does accept the variable $SERVICE
ENTRYPOINT ["handler"]
