# Build jupiter-brain in a separate container
FROM golang:1.11 AS builder

RUN go get github.com/FiloSottile/gvt
RUN update-ca-certificates

WORKDIR /go/src/github.com/travis-ci/jupiter-brain

COPY . .
RUN make deps
ENV CGO_ENABLED 0
RUN make build

FROM scratch

# Copy things from the other stages
COPY --from=builder /go/bin/jb-server .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

ENTRYPOINT ["./jb-server"]
