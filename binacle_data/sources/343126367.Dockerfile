FROM golang:1.10-alpine as builder

ENV GOPATH /go

WORKDIR "$GOPATH/src/github.com/your-name/repo-name"

RUN apk --no-cache add git ca-certificates tini=0.16.1-r0 && \
    go get -u github.com/golang/dep/...

COPY . .

RUN dep ensure -v --vendor-only && \
    CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main . && mv main /tmp/


FROM alpine:3.7

LABEL maintainer="Jose Armesto <jose@armesto.net>"

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["./main"]

COPY --from=builder /sbin/tini /sbin/tini
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /tmp/main .
