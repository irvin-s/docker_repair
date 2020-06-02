FROM golang:1.10-alpine as build

MAINTAINER alex@openfaas.com
LABEL maintainer alex@openfaas.com

RUN apk --no-cache add ca-certificates \
     && apk --no-cache add --virtual build-deps git

COPY ./ /go/src/github.com/alexellis/github-exporter
WORKDIR /go/src/github.com/alexellis/github-exporter

RUN go test ./... \
 && go build -o /bin/main

FROM alpine:3.9

RUN apk --no-cache add ca-certificates \
     && addgroup exporter \
     && adduser -S -G exporter exporter

USER exporter
COPY --from=build /bin/main /bin/main
ENV LISTEN_PORT=9171
EXPOSE 9171
ENTRYPOINT [ "/bin/main" ]
