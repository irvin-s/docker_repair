# Golang binary building stage
FROM golang:1.9.2
RUN go get -d -v github.com/nats-io/go-nats
RUN go get -d -v github.com/golang/protobuf/proto
RUN CGO_ENABLED=0 go build -v ./src/github.com/nats-io/go-nats/examples/nats-bench.go

# Final docker image building stage
FROM scratch
COPY --from=0  /go/nats-bench /nats-bench
ENTRYPOINT ["/nats-bench"]
