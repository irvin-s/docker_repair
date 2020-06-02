FROM golang:1.11-alpine as builder
WORKDIR /go/src/github.com/battlesnakeio/engine/
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go install -installsuffix cgo ./cmd/...

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=builder /go/bin/ /bin/
CMD ["/bin/engine"]
