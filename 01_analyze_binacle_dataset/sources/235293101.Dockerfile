FROM golang:1.9
ADD . /go/src/github.com/Colstuwjx/elastic-adapter
ENV CGO_ENABLED=0
RUN go install github.com/Colstuwjx/elastic-adapter

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=0 /go/bin/elastic-adapter /usr/local/bin/elastic-adapter
ENTRYPOINT ["/usr/local/bin/elastic-adapter"]
