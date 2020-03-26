FROM golang:1.10-alpine3.7
ADD . /go/src/storage/user
RUN apk add --no-cache git
RUN go get storage/user
RUN go install storage/user
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/user .
CMD ["/user"]
