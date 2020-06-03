FROM alpine:3.1

ADD controller /bin/

RUN apk update && apk add ca-certificates

ENTRYPOINT ["/bin/controller"]

