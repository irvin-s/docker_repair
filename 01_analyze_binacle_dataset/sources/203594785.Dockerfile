FROM golang:1.10-alpine3.7
ADD . /go/src/spanner/admin
RUN apk add --no-cache git
RUN go get spanner/admin
RUN go install spanner/admin

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/admin .
CMD ["/admin"]
