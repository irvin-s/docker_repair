FROM golang:1.10-alpine3.7
RUN apk add --no-cache git
RUN go get cloud.google.com/go/bigtable
ADD . /go/src/counter
WORKDIR /go/src/counter
RUN go install

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/counter .
CMD ./counter
