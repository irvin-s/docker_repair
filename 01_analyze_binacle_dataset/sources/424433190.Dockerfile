FROM golang:1.10.3 AS builder
WORKDIR /build
COPY . /go/src/github.com/jimmysawczuk/go-binary
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app github.com/jimmysawczuk/go-binary

FROM alpine
WORKDIR /home
RUN apk add --no-cache tzdata
COPY --from=builder /build/app /usr/bin/go-binary
ENTRYPOINT ["go-binary"]
