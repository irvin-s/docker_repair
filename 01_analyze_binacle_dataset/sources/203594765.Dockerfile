FROM golang:1.10-alpine3.7
RUN apk add --no-cache git
RUN go get cloud.google.com/go/bigtable
ADD . /go/src/admin
WORKDIR /go/src/admin
RUN go install

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/admin .
CMD ./admin
