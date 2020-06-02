FROM golang:1.10-alpine3.7
RUN apk add --no-cache git
RUN go get -u cloud.google.com/go/pubsub
ADD . /go/src/subscriber
WORKDIR /go/src/subscriber
RUN go install -i

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/subscriber .
CMD ["./subscriber"]
