FROM alpine:3.4
ARG arch=amd64

RUN apk add --update ca-certificates
ADD bin/vault-monkey-linux-${arch} /app/vault-monkey

ENTRYPOINT ["/app/vault-monkey"]
