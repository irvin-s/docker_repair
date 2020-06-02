FROM golang:1.8-alpine AS builder
WORKDIR /go/src/github.com/drasko/edgex-auth/example
COPY . .
RUN cd cmd && CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o exe

FROM scratch
COPY --from=builder /go/src/github.com/drasko/edgex-auth/example/exe /
EXPOSE 8181
ENTRYPOINT ["/exe"]
