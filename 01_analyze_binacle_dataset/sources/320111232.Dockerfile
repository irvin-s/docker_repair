FROM golang:1.10.1-alpine3.7 as builder
WORKDIR /go/src/github.com/keelerh/omniscience
COPY . .
RUN go build -o /server cmd/omniscience_server/main.go

FROM alpine:3.7  
ENTRYPOINT ["./server"]
COPY --from=builder /server .