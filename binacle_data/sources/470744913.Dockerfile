# Build the manager binary
FROM golang:1.11.5-stretch as builder

# Copy in the go src
WORKDIR /go/src/github.com/containers-ai/alameda
ADD . .

# Build
RUN ["/bin/bash", "-c", "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags \"-X github.com/containers-ai/alameda/cmd/app.VERSION=`git rev-parse --abbrev-ref HEAD`-`git rev-parse --short HEAD``git diff --quiet || echo '-dirty'` -X 'github.com/containers-ai/alameda/cmd/app.BUILD_TIME=`date`' -X 'github.com/containers-ai/alameda/cmd/app.GO_VERSION=`go version`'\" -a -o ./bin/admission-controller  github.com/containers-ai/alameda/admission-controller/cmd"]

# Copy the controller-manager into a thin image
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /go/src/github.com/containers-ai/alameda/bin/admission-controller .
COPY --from=builder /go/src/github.com/containers-ai/alameda/admission-controller/etc/admission-controller.yml /etc/alameda/admission-controller/admission-controller.yml
EXPOSE 8000/tcp
ENTRYPOINT ["./admission-controller", "run"]
