FROM golang:1.10-alpine3.7
ADD . /go/src/storage/cleanup
RUN apk add --no-cache git
RUN go get storage/cleanup
RUN go install storage/cleanup
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/cleanup .
CMD ["/cleanup"]
