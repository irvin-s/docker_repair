FROM golang:1.12-alpine as builder

RUN mkdir -p $GOPATH/src/app
WORKDIR $GOPATH/src/app
ADD . .

RUN go get ./...
RUN GO111MODULE=off GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -ldflags="-w -s"  -o $GOPATH/src/app

FROM alpine:3.9 as ca
RUN adduser -D -g '' appuser

# (optional) adds certificate if the services needs to communicate with services expose on the web
RUN apk add -U --no-cache ca-certificates

FROM scratch
COPY --from=ca /etc/passwd /etc/passwd
COPY --from=ca /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/app .

# Our typical port which our Go programs listen on
EXPOSE 9000

USER appuser
ENTRYPOINT   [ "./app" ]