FROM alpine:3.3

RUN apk --update add redis
ENTRYPOINT redis-server
