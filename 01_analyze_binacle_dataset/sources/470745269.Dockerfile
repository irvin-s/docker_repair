# Build the manager binary
FROM golang:1.11.5-stretch as builder

# Copy in the go src
WORKDIR /go/src/github.com/containers-ai/alameda
ADD . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X main.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'main.BUILD_TIME=`date`' -X 'main.GO_VERSION=`go version`'\" -a -o ./operator/manager github.com/containers-ai/alameda/operator/cmd/manager"]

# Copy the controller-manager into a thin image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /go/src/github.com/containers-ai/alameda/operator/etc/operator.yml /etc/alameda/operator/operator.yml
COPY --from=builder /go/src/github.com/containers-ai/alameda/operator/manager .
COPY --from=builder /go/src/github.com/containers-ai/alameda/operator/config/crds /etc/alameda/operator/crds
EXPOSE 50050/tcp 50443/tcp
ENTRYPOINT ["./manager"]
