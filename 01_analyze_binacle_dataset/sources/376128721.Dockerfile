# Build stage
FROM golang:1.12rc1-alpine3.9 AS build-stage

RUN apk add --no-cache git 
RUN go get gopkg.in/go-playground/webhooks.v5/github
RUN go get github.com/badoux/checkmail

ADD . /src
RUN cd /src && go build -o dispatch

# Release stage
FROM alpine:3.9
RUN apk update \
        && apk upgrade \
        && apk add --no-cache \
        ca-certificates \
        && update-ca-certificates 2>/dev/null || true
COPY --from=build-stage /src/dispatch /

LABEL version="v1.0.1"
LABEL repository="https://github.com/hecateapp/dispatch-action"
LABEL homepage="https://github.com/hecateapp/dispatch-action"
LABEL maintainer="Hecate <hello@hecate.co>"

LABEL "com.github.actions.name"="Hecate Dispatch"
LABEL "com.github.actions.description"="Sends emails to stakeholders when pull requests are merged."
LABEL "com.github.actions.icon"="mail"
LABEL "com.github.actions.color"="purple"

ENTRYPOINT ["/dispatch"]