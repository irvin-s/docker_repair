FROM alpine:3.4

RUN apk add --no-cache --update ca-certificates bash

COPY bin/demo /demo

EXPOSE 8080

CMD ["/demo"]
