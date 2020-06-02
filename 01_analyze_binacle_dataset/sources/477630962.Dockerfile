FROM golang:1.11.5 as builder

WORKDIR /shorty
COPY . .
RUN go test -mod=vendor ./...
RUN go build -mod=vendor

FROM alpine:latest

RUN apk update && apk add ca-certificates

RUN addgroup -S shorty && adduser -S -G shorty shorty
USER shorty
WORKDIR /home/shorty
COPY --from=builder /shorty/shorty .
COPY --from=builder /shorty/assets assets

CMD ["./shorty"]
