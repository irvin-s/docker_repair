FROM alpine:3.4

RUN apk --no-cache add ca-certificates

COPY kafka-client /kafka-client

ENTRYPOINT ["/kafka-client"]