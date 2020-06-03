# Golang binary building stage
FROM golang:1.11
RUN go get -d -v github.com/nats-io/go-nats
RUN go get -d -v github.com/nats-io/go-nats-streaming
RUN go get -d -v github.com/golang/protobuf/proto
RUN CGO_ENABLED=0 go build -v -o /stan-bench ./src/github.com/nats-io/go-nats-streaming/examples/stan-bench/main.go

# Final docker image building stage
FROM scratch
COPY --from=0  /stan-bench /stan-bench
ENTRYPOINT ["/stan-bench"]
