FROM golang:1.10-alpine3.7
ADD . /go/src/musicians
RUN apk add --no-cache git
WORKDIR /go/src/musicians
RUN go get ./...
RUN go install musicians

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/musicians .
CMD ["/musicians"]
