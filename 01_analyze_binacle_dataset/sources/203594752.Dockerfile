FROM golang:1.10-alpine3.7
ADD . /go/src/bigquery
RUN apk add --no-cache git
RUN go get bigquery
RUN go install bigquery

FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=0 /go/bin/bigquery .
CMD ["/bigquery"]
