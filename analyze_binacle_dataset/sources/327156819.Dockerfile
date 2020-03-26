FROM golang:1.10.3 AS builder
WORKDIR /go/src/github.com/sethvargo/vault-token-helper-gcp-kms
ADD . .
RUN make dev

FROM scratch
ADD https://curl.haxx.se/ca/cacert.pem /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /go/bin/vault-token-helper-gcp-kms /
ENTRYPOINT ["/vault-token-helper-gcp-kms"]
