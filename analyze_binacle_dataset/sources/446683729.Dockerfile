FROM alpine:3.5

RUN apk add --no-cache ca-certificates

COPY simpleserver_deploy .
ENTRYPOINT ["/simpleserver_deploy"]
