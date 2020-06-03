# BUILDER
FROM golang:1.10 AS builder
COPY . /go/src/github.com/lawrencegripper/azurefrontdooringress
WORKDIR /go/src/github.com/lawrencegripper/azurefrontdooringress
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo

# RUNNER
FROM alpine:3.7
ARG SERVICE=dispatcher
RUN apk --no-cache --update add \
    ca-certificates
WORKDIR /usr/local/bin
COPY --from=builder /go/bin/azurefrontdooringress .

ENTRYPOINT ["azurefrontdoor-ingress"]