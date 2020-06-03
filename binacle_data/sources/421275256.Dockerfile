FROM golang AS builder
WORKDIR /root
COPY . .
RUN \
  CGO_ENABLED=0 \
  GOOS=linux \
  GOARCH=amd64 \
  go build -ldflags="-s -w"

FROM busybox
MAINTAINER stefansundin https://github.com/stefansundin/go-lambda-gateway
COPY --from=builder /root/go-lambda-gateway .
ENTRYPOINT ["./go-lambda-gateway"]
