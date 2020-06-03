FROM golang:1.10.1-alpine3.7 as builder
WORKDIR /go/src/github.com/keelerh/omniscience
COPY . .
RUN go build -o /ingester-github cmd/ingester/github/main.go

FROM golang:1.10.1-alpine3.7
ENTRYPOINT ["./ingester-github"]
COPY --from=builder /ingester-github .
