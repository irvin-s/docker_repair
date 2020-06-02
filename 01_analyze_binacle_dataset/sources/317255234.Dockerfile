FROM golang:1.10 AS builder

RUN go get -u github.com/golang/dep/...

RUN mkdir -p /go/src/github.com/rodrigodiez/zorro
WORKDIR /go/src/github.com/rodrigodiez/zorro

COPY . .
RUN dep ensure

RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags '-w' -o zorro-http ./cmd/zorro-http

FROM alpine
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

COPY --from=builder /go/src/github.com/rodrigodiez/zorro/zorro-http /zorro-http
EXPOSE 8080/tcp
ENTRYPOINT [ "/zorro-http" ]