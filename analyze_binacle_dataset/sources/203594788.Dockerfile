FROM golang:1.10-alpine3.7
ADD . /go/src/cloud-spanner/guestbook
RUN apk add --no-cache git
RUN go get cloud-spanner/guestbook
RUN go install cloud-spanner/guestbook

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/guestbook .
CMD ["/guestbook"]
