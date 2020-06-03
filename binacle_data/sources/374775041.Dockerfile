# Build the manager binary
FROM golang:1.10.3 as builder

# Copy in the go src
WORKDIR /go/src/github.com/kiwigrid/gcp-serviceaccount-controller
COPY pkg/    pkg/
COPY cmd/    cmd/
COPY vendor/ vendor/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o manager github.com/kiwigrid/gcp-serviceaccount-controller/cmd/manager

# Copy the controller-manager into a thin image
FROM alpine:latest
RUN set -eux; apk add --no-cache ca-certificates gnupg openssl libcap su-exec dumb-init
WORKDIR /root/
COPY --from=builder /go/src/github.com/kiwigrid/gcp-serviceaccount-controller/manager .
ENTRYPOINT ["./manager"]
