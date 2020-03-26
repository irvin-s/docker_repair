ARG GO_VERSION=1.12

FROM golang:${GO_VERSION}-alpine AS builder
WORKDIR /coffeefinder
COPY ./ .
RUN apk update && apk add --no-cache git ca-certificates
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o app .

FROM alpine:3.9
RUN addgroup -S -g 1710 coffeefinder && adduser -S coffeefinder -G coffeefinder
USER coffeefinder
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /coffeefinder/app .
EXPOSE 8080
CMD ["./app"]
